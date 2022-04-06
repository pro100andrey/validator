# Validator

The validator package comes with several common validations and removes the boiler plate code from your project.

## Installation

``` yaml
dependencies:
  flutter:
    sdk: flutter
  validator:
    git: https://github.com/pro100andrey/validator.git
```

## Example

``` dart
import 'package:validator/validator.dart';

final emailValidator = GroupValidator([
    RequiredValidator(error: 'Required field'),
    EmailValidator(error: 'Invalid email'),
  ]);

final passwordValidator = GroupValidator([
    RequiredValidator(error: 'Required field'),
    MinLengthValidator(8, error: 'Min length 8'),
    MinOneUppercaseValidator(error: 'Must contain at least one uppercase'),
    MinOneLowercaseValidator(error: 'Must contain at least one lowercase'),
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
| RequiredValidator | Ensures the value is not empty, nor white space only. |
| MaxLengthValidator | Ensures the value length contains no more than a set [max] of characters. |
| MinLengthValidator | Ensures the value length contains no fewer than a set [min] of characters. |
| MinOneUppercaseValidator | Ensures the value contains a minimum of one uppercase character. |
| MinOneLowercaseValidator | Ensures the value contains a minimum of one lowercase character. |
| HasANumberValidator |  Ensures the value contains a minimum of one numeric character. |
| LengthRangeValidator | Ensures the value length is contained in the range [min, max]. |
| NumRangeValidator |  Ensures the num value is contained in the range [min, max]. |
| EmailValidator | Ensures the value is a validly formatted email address. |
| PhoneValidator | Ensures the value is a validly formatted phone number with + or 0, no length limitations, and handles #, x, ext, extension conventions. |
| UrlValidator | Ensures the value is a validly formatted URL. |
| MatchValidator | Ensures a custom regular expression string. |
| GroupValidator | Group together and validate the basic validators. |
