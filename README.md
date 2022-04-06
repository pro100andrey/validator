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
| RequiredValidator | Defines if the input string is required. |
| MaxLengthValidator | Defines the maximum length of the input string. |
| MinLengthValidator | Defines the minimum length of the input string. |
| MinOneUppercaseValidator | Defines the minimum one of uppercase characters in the input string. |
| MinOneLowercaseValidator | Defines the minimum one of lowercase characters in the input string. |
| HasANumberValidator |  Defines the minimum one of number characters in the input string. |
| LengthRangeValidator | Defines the minimum and maximum length of the input string. |
| NumRangeValidator |  Defines the minimum and maximum numeric value of the input string. |
| EmailValidator | Defines the email address of the input string. |
| PhoneValidator | It recognizes the phone numbers starting with + or 0, no length limitations and handles #, x, ext, extension extension conventions. |
| UrlValidator | Defines the URL pattern of the input string. |
| MatchValidator | Defines a custom regular expression string. |
| GroupValidator | Group together and validate the basic validators. |
