# Validator

The validator package comes with several common validations and removes the boiler plate code from your project.

## Features

- Contains several common validations
- Supports grouping of validators to write concise code
- Zero dependency
- Well tested
- Easy to use and removes boiler plate code from your project

## Installation

``` yaml
dependencies:
  flutter:
    sdk: flutter
  validator:
    git: https://github.com/pro100andrey/validator.git
```

## Example

> **_NOTE:_** if validate value contains is a null value, the result is null, not an error.

``` dart
import 'package:validator/validator.dart';

final emailValidator = MultiValidator([
    RequiredValidator(error: 'Required field'),
    EmailValidator(error: 'Invalid email'),
  ]);

final passwordValidator = MultiValidator([
    RequiredValidator(error: 'Required field'),
    MinLengthValidator(8, error: 'Min length 8'),
    HasUppercaseValidator(error: 'Must contain at least one uppercase'),
    HasLowercaseValidator(error: 'Must contain at least one lowercase'),
  ]);

void main() {
    // returns 'Required Field'
    print(emailValidator(''));
    // returns 'Invalid email'
    print(emailValidator('mail@com'));

    // returns 'Min length 8'
    print(passwordValidator('123'));
    // returns 'Must contain at least one uppercase'
    print(passwordValidator('12345678'));
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
| PhoneValidator | Ensures the value is a validly formatted phone number with + or 0, no length limitations, and handles #, x, ext, extension conventions. |
| UrlValidator | Ensures the value is a validly formatted URL. |
| MatchValidator | Ensures a custom regular expression string. |
| MultiValidator | Group together and validate the basic validators. |
