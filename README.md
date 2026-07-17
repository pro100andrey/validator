# pro_validator

The validator package comes with several common validations and removes the
boilerplate code from your project.

## Features

- One tiny core: every validator is a callable `Validator<T>` — call it with
  a value, get `null` (valid) or the error message back
- A rich set of ready-made validators for **text** (required, length, email,
  phone, URL, credit card, custom pattern, …), **numbers** (min/max/range,
  positive, multiple-of, …) and **dates** (before/after/range, past/future)
- Compose validators of any type with `ValidatorGroup` or the `&` operator;
  collect the first error **or every** failing error at once
- Assemble your own in one line: `PredicateValidator` for any closure,
  `PatternValidator` for a custom regex, `Patterns.slug.toValidator(...)` for
  any of the 40+ built-in formats
- Whole-model validation with cross-field rules, conditions and rule-sets
  (experimental)
- A low-level layer of `isX` string checkers and `String` extensions
  (`'user@mail.com'.isEmail`) covering 40+ formats
- Pure Dart, works on every platform

## Install

```bash
dart pub add pro_validator
# or, for Flutter:
flutter pub add pro_validator
```

## Empty & null handling

Every validator handles "empty" input the same way, in one place. Empty means
`null` — and, for text, blank strings too.

By design, **only `RequiredValidator` fails on empty input**. Every other
validator treats empty input as valid and skips its check, so an *optional*
field never reports a format error when left blank. Combine a
`RequiredValidator` with a format validator when a field is mandatory.

If you need any validator to also reject empty input, pass
`ignoreEmptyValues: false` — empty input then fails with the validator's
error.

## Example

```dart
import 'package:pro_validator/pro_validator.dart';

void main() {
  // Compose with the `&` operator (reports the first error).
  final email = const RequiredValidator(error: 'Required field') &
      const EmailValidator(error: 'Invalid email');

  print(email(null));            // Required field
  print(email(''));              // Required field
  print(email('mail@com'));      // Invalid email
  print(email('mail@mail.com')); // null

  // Or group explicitly and collect every failing rule.
  const password = ValidatorGroup([
    RequiredValidator(error: 'Required field'),
    MinLengthValidator(min: 8, error: 'Min length 8'),
    HasUppercaseValidator(error: 'Need an uppercase letter'),
    HasANumberValidator(error: 'Need a number'),
  ]);

  print(password('abc'));         // Min length 8  (first error)
  print(password.errors('abc'));  // [Min length 8, Need an uppercase letter, Need a number]

  // Typed values work exactly the same way.
  final age = const MinValidator(min: 18, error: 'Adults only') &
      const MaxValidator(max: 120, error: 'Too old');
  print(age(15));   // Adults only
  print(age(30));   // null
  print(age(null)); // null — optional by default

  // Confirm two values match (e.g. password confirmation).
  const match = MatchValidator(error: 'Do not match');
  print(match('secret', 'secret')); // null
}
```

### With a Flutter `TextFormField`

```dart
TextFormField(
  validator: (const RequiredValidator(error: 'Required') &
          const EmailValidator(error: 'Invalid email'))
      .call,
);
```

### Assemble your own validator

No subclassing needed — build one from a closure, a regex, or any built-in
`Patterns` entry:

```dart
// Any predicate, any type.
final finite = PredicateValidator<num>(
  (v) => v.isFinite,
  error: 'Must be a finite number',
);

// A custom regex (compiled once, cached).
final hex = PatternValidator(pattern: r'^#[0-9a-fA-F]{6}$', error: 'Not a hex color');

// Any of the 40+ built-in formats — reuses the already-compiled regex.
final slug = Patterns.slug.toValidator(error: 'Invalid slug');
final iban = Patterns.iban.toValidator(error: 'Invalid IBAN');

// They all compose like any other validator.
final code = const RequiredValidator(error: 'Required') &
    Patterns.hexColor.toValidator(error: 'Not a color');
```

### Whole-model validation (experimental)

Validate an entire object — cross-field rules, conditions and rule-sets —
reusing the same validators:

```dart
class UserValidator extends ModelValidator<User> {
  UserValidator() {
    ruleFor('email')
        .check((u) => u.email, const RequiredValidator(error: 'Required'))
        .check((u) => u.email, const EmailValidator(error: 'Invalid email'));

    ruleFor('age')
        .check((u) => u.age, const MinValidator(min: 18, error: '18+'));

    ruleFor('confirm')
        .must((u) => u.confirm == u.password, error: 'Passwords differ');

    ruleFor('id')
        .check((u) => u.id, const RequiredValidator(error: 'Required'))
        .only('update'); // runs only for validate(user, ruleSet: 'update')
  }
}

final result = UserValidator().validate(user);
result.isValid;             // false
result.firstFor('email');   // 'Invalid email'
```

The model layer is marked `@experimental`: it works and is fully tested, but
its API may still change in a minor release.

### Low-level checkers and extensions

```dart
isEmail('user@mail.com');            // true
isLuhnValid('79927398713');          // true
'123E4567-E89B-12D3-A456-426614174000'.isUuid; // true
'#FF8800'.isHexColor;                // true
```

## Available Validators

### Text (`Validator<String>`)

| Validator | Description |
| - | - |
| RequiredValidator | Ensures the value is not empty and not whitespace only. |
| MaxLengthValidator | Ensures the value length is no more than `max` characters. |
| MinLengthValidator | Ensures the value length is no fewer than `min` characters. |
| LengthRangeValidator | Ensures the value length is within `[min, max]`. |
| NumRangeValidator | Ensures the numeric value of the input is within `[min, max]`. |
| HasUppercaseValidator | Ensures the value contains at least one uppercase character. |
| HasLowercaseValidator | Ensures the value contains at least one lowercase character. |
| HasANumberValidator | Ensures the value contains at least one numeric character. |
| EmailValidator | Ensures the value is a validly formatted email address. |
| PhoneValidator | Ensures the value is a validly formatted phone number. |
| UrlValidator | Ensures the value is a validly formatted URL. |
| CreditCardValidator | Ensures the value is a card number matching a known scheme **and** passing the Luhn checksum. |
| PatternValidator | Ensures the value matches a custom regular expression. |
| OneOfValidator | Ensures the value is one of an allowed set. |
| FileExtensionValidator | Ensures a file name ends with an allowed extension. |
| ConditionalValidator | Runs an inner validator only when a condition holds. |

### Numbers (`Validator<num>`)

| Validator | Description |
| - | - |
| MinValidator | Ensures the number is `>= min`. |
| MaxValidator | Ensures the number is `<= max`. |
| RangeValidator | Ensures the number is within `[min, max]`. |
| PositiveValidator | Ensures the number is `> 0`. |
| NegativeValidator | Ensures the number is `< 0`. |
| MultipleOfValidator | Ensures the number is a multiple of `factor` (with optional float `tolerance`). |
| EvenValidator / OddValidator | Ensures the number is even / odd. |

### Dates (`Validator<DateTime>`)

| Validator | Description |
| - | - |
| AfterValidator | Ensures the date is strictly after a given instant. |
| BeforeValidator | Ensures the date is strictly before a given instant. |
| DateRangeValidator | Ensures the date is within `[start, end]`. |
| PastValidator / FutureValidator | Ensures the date is in the past / future (injectable `clock` for tests). |

### Composition & special

| Validator | Description |
| - | - |
| ValidatorGroup\<T\> | Groups validators of one type; returns the first error, or every error via `errors()`. Build with `&`. |
| PredicateValidator\<T\> | Wraps any `bool Function(T)` predicate — a one-off check without declaring a class. |
| Patterns.x.toValidator | Builds a `PatternValidator` from any of the 40+ built-in `Patterns` entries. |
| MatchValidator | Checks that two values are equal (e.g. password confirmation). |
| ModelValidator\<T\> | Whole-model validation: `ruleFor`, cross-field `must`, `when`/`unless`, rule-sets. *Experimental.* |

## String checkers

Every `Patterns` entry is exposed both as a top-level `isX(String)` function
and as a `String` getter extension. Supported formats include: alphabetic,
alphanumeric, integer, decimal, numeric, hexadecimal, hex color, base64, UUID
(v3/v4/v5/any/compact), IPv4/IPv6, MAC, JWT, URL, email (simple & RFC 5322),
postal code, phone number, credit card, Luhn, date/time/datetime/ISO 8601,
HTML tag, slug, hashtag, latitude, longitude, geo-coordinates, IBAN, SWIFT/BIC
and VAT.
