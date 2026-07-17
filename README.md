# pro_validator

The validator package comes with several common validations and removes the
boilerplate code from your project.

## Features

- A rich set of ready-made validators (required, length, email, phone, URL,
  credit card, custom pattern, …)
- Compose validators with `MultiValidator` or the `&` operator
- Collect the first error **or every** failing error at once
- Conditional and value-constrained validators
- A low-level layer of `isX` string checkers and `String` extensions
  (`'user@mail.com'.isEmail`) covering 40+ formats
- Zero runtime dependencies, works on every platform

## Install

```bash
dart pub add pro_validator
# or, for Flutter:
flutter pub add pro_validator
```

## Empty & null handling

By design, **only `RequiredValidator` fails on empty or `null` input**. Every
other validator treats empty/`null` as valid and skips its check, so an *optional*
field never reports a format error when left blank. Combine a
`RequiredValidator` with a format validator when a field is mandatory.

If you need a format validator to also reject empty input, pass
`ignoreEmptyValues: false`.

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
  const password = MultiValidator(
    validators: [
      RequiredValidator(error: 'Required field'),
      MinLengthValidator(min: 8, error: 'Min length 8'),
      HasUppercaseValidator(error: 'Need an uppercase letter'),
      HasANumberValidator(error: 'Need a number'),
    ],
  );

  print(password('abc'));         // Min length 8  (first error)
  print(password.errors('abc'));  // [Min length 8, Need an uppercase letter, Need a number]

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

### Low-level checkers and extensions

```dart
isEmail('user@mail.com');            // true
isLuhnValid('79927398713');          // true
'123E4567-E89B-12D3-A456-426614174000'.isUuid; // true
'#FF8800'.isHexColor;                // true
```

## Available Validators

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
| MatchValidator | Checks that two values are equal (e.g. password confirmation). |
| MultiValidator | Groups validators; returns the first error, or every error via `errors()`. |

## String checkers

Every `Patterns` entry is exposed both as a top-level `isX(String)` function
and as a `String` getter extension. Supported formats include: alphabetic,
alphanumeric, integer, decimal, numeric, hexadecimal, hex color, base64, UUID
(v3/v4/v5/any/compact), IPv4/IPv6, MAC, JWT, URL, email (simple & RFC 5322),
postal code, phone number, credit card, Luhn, date/time/datetime/ISO 8601,
HTML tag, slug, hashtag, latitude, longitude, geo-coordinates, IBAN, SWIFT/BIC
and VAT.
