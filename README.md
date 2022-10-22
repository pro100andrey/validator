# pro_validator

The validator package comes with several common validations and removes the boiler plate code from your project.

## Features

- Contains several common validations
- Supports grouping of validators to write concise code
- Zero dependency
- Well tested
- Easy to use and removes boiler plate code from your project

# How to use
## Install

```bash
flutter pub add input_validation
```

## Example

> **_NOTE:_** if validate value contains is a null value, the result is null, not an error.

``` dart
import 'package:input_validation/input_validation.dart';

void main() {
  const emailValidator = MultiValidator(
    validators: [
      RequiredValidator(error: 'Required field'),
      EmailValidator(error: 'Invalid email'),
    ],
  );

  print('null email validation ${emailValidator(null)}');
  print('empty email validation ${emailValidator('')}');
  print('invalid email validation ${emailValidator('mail@com')}');
  print('valid email validation ${emailValidator('mail@mail.com')}');

  const passwordValidator = MultiValidator(
    validators: [
      RequiredValidator(error: 'Required field'),
      MinLengthValidator(min: 8, error: 'Min length 8'),
      HasUppercaseValidator(error: 'Must contain at least one uppercase'),
      HasLowercaseValidator(error: 'Must contain at least one lowercase'),
    ],
  );

  print('null password validation ${passwordValidator(null)}');
  print('empty password validation ${passwordValidator('')}');
  print('min length password validation ${passwordValidator('1232')}');
  print('invalid password validation ${passwordValidator('12345678')}');
  print('invalid password validation ${passwordValidator('12345678A')}');
  print('valid password validation ${passwordValidator('a12345678A')}');

  final matchValidator = MatchValidator(error: 'Do not match');

  print('match validation ${matchValidator('a', 'b')}');
}

```

## Available Validators

| Validator | Description |
| - | - |
| RequiredValidator | Ensures the value is not empty, not white space only. |
| MaxLengthValidator | Ensures the value length contains no more than a set [max] of characters. |
| MinLengthValidator | Ensures the value length contains no fewer than a set [min] of characters. |
| HasUppercaseValidator | Ensures the value contains a minimum of one uppercase character. |
| HasLowercaseValidator | Ensures the value contains a minimum of one lowercase character. |
| HasANumberValidator |  Ensures the value contains a minimum of one numeric character. |
| LengthRangeValidator | Ensures the value length is contained in the range [min, max]. |
| NumRangeValidator |  Ensures the num value is contained in the range [min, max]. |
| EmailValidator | Ensures the value is a validly formatted email address. |
| PhoneValidator | Ensures the value is a validly formatted phone number. |
| UrlValidator | Ensures the value is a validly formatted URL. |
| PatternValidator | Ensures a custom regular expression string. |
| MatchValidator | A special match validator to check if the v1 equals v2 value. |
| MultiValidator | Group together and validate the basic validators. |
