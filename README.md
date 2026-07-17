# pro_validator

[![pub package](https://img.shields.io/pub/v/pro_validator.svg)](https://pub.dev/packages/pro_validator)

Composable, callable validators for Dart and Flutter. One tiny core —
`Validator<T>` — behind ready-made validators for text, numbers and dates,
one-line custom validators, whole-model validation and a low-level layer of
40+ string format checkers.

```dart
final email = const RequiredValidator(error: 'Required') &
    const EmailValidator(error: 'Invalid email');

email(null);            // 'Required'
email('mail@com');      // 'Invalid email'
email('mail@mail.com'); // null
```

A validator **is** the validation callback: `Validator<String>` matches
Flutter's `FormFieldValidator<String>`, so it plugs straight into a form
field — no glue code:

```dart
TextFormField(validator: email.call);
```

## Install

```bash
dart pub add pro_validator
# or, for Flutter:
flutter pub add pro_validator
```

Pure Dart, works on every platform.

## The contract

Every validator follows the same three rules.

**1. Callable.** `validator(value)` returns `null` when the value is
acceptable, or the `error` message when it is not. That's the whole API.

**2. Empty input is handled once, uniformly.** Empty means `null` — and, for
text, blank strings too. By design, **only `RequiredValidator` fails on empty
input**; every other validator skips its check, so an *optional* field never
reports a format error when left blank. Combine with `RequiredValidator` when
the field is mandatory:

```dart
final mandatory = const RequiredValidator(error: 'Required') &
    const UrlValidator(error: 'Invalid URL');

const optional = UrlValidator(error: 'Invalid URL');
optional('');                    // null — blank is fine, field is optional
mandatory('');                   // 'Required'
```

Need a single validator to reject empty input on its own? Pass
`ignoreEmptyValues: false` — empty input then fails with its `error`.

**3. Composable.** The `&` operator (or an explicit `ValidatorGroup`) chains
validators of the same value type; the group reports the **first** failing
error, or all of them via `errors()`:

```dart
const password = ValidatorGroup([
  RequiredValidator(error: 'Required'),
  MinLengthValidator(min: 8, error: 'Min length 8'),
  HasUppercaseValidator(error: 'Need an uppercase letter'),
  HasANumberValidator(error: 'Need a number'),
]);

password('abc');        // 'Min length 8'  — first error
password.errors('abc'); // ['Min length 8', 'Need an uppercase letter', …]
```

Everything above is typed, not text-only. Numbers and dates get the same
treatment — skipping, `&`, groups:

```dart
final age = const MinValidator(min: 18, error: 'Adults only') &
    const MaxValidator(max: 120, error: 'Too old');
age(15);   // 'Adults only'
age(30);   // null
age(null); // null — optional by default

final delivery = AfterValidator(dateTime: DateTime(2026), error: 'Too early');

// Past/Future accept an injectable clock for deterministic tests.
final birthday = PastValidator(error: 'Must be in the past');
```

## Build your own validator

Four ways, from lightest to fullest — all of them compose like any other
validator:

```dart
// 1. Any predicate, any type — no class needed.
final finite = PredicateValidator<num>(
  (v) => v.isFinite,
  error: 'Must be a finite number',
);

// 2. A custom regex (compiled once, cached).
final hex = PatternValidator(
  pattern: r'^#[0-9a-fA-F]{6}$',
  error: 'Not a hex color',
);

// 3. Any of the 40+ built-in formats — reuses the already-compiled regex.
final slug = Patterns.slug.toValidator(error: 'Invalid slug');
final iban = Patterns.iban.toValidator(error: 'Invalid IBAN');
```

And when a rule deserves a name and reuse, subclass `TextValidator` (or
`Validator<T>` for other types) and implement a single method — empty
handling and composition come from the base:

```dart
class EvenLengthValidator extends TextValidator {
  const EvenLengthValidator({required super.error, super.ignoreEmptyValues});

  @override
  bool isValid(String value) => value.length.isEven;
}
```

## Whole-model validation (experimental)

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

    ruleFor('code')
        .check((u) => u.code, const RequiredValidator(error: 'Required'))
        .when((u) => u.wantsDiscount);

    ruleFor('id')
        .check((u) => u.id, const RequiredValidator(error: 'Required'))
        .only('update'); // runs only for validate(user, ruleSet: 'update')
  }
}

final result = UserValidator().validate(user);
result.isValid;           // false
result.firstFor('email'); // 'Invalid email'
result.errorsFor('age');  // every failing message for the field
```

The model layer is marked `@experimental`: it works and is fully tested, but
its API may still change in a minor release.

## Low-level string checkers

Every `Patterns` entry is exposed three ways — pick whichever reads best:

```dart
isEmail('user@mail.com');                      // top-level checker
'user@mail.com'.isEmail;                       // String extension
Patterns.email.hasMatch('user@mail.com');      // the pattern itself

isLuhnValid('79927398713');                    // true
'123E4567-E89B-12D3-A456-426614174000'.isUuid; // true
'#FF8800'.isHexColor;                          // true
```

Supported formats include: alphabetic, alphanumeric, integer, decimal,
numeric, hexadecimal, hex color, base64, UUID (v3/v4/v5/any/compact),
IPv4/IPv6, MAC, JWT, URL, email (simple & RFC 5322), postal code, phone
number, credit card, Luhn, date/time/datetime/ISO 8601, HTML tag, slug,
hashtag, latitude, longitude, geo-coordinates, IBAN, SWIFT/BIC and VAT.

## Validator reference

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
| PatternValidator | Ensures the value matches a custom regular expression (`fromRegExp` for a pre-compiled one). |
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

## Upgrading from 2.x

| 2.x | 3.0 |
| - | - |
| `MultiValidator(validators: [...])` | `ValidatorGroup([...])` — now typed, works for `num`/`DateTime` too |
| `MatchValidator` compared with `identical` | compares with `==`, so equal runtime strings match |
| `RequiredValidator` could be short-circuited on empty input | always fails on empty/`null` |
| `ignoreEmptyValues: false` ran the check against `''` | empty input fails immediately with the validator's `error` |

Everything callable stayed callable — passing `validator.call` (or the
validator itself) as a Flutter `validator:` works exactly as before. See the
[CHANGELOG](CHANGELOG.md) for the full list.
