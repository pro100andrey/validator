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
| RequiredValidator | ... |
| MaxLengthValidator | ... |
| MinLengthValidator | ... |
| MinOneUppercaseValidator | ... |
| MinOneLowercaseValidator | ... |
| HasANumberValidator | ... |
| LengthRangeValidator | ... |
| NumRangeValidator | ... |
| EmailValidator | ... |
| PhoneValidator | ... |
| UrlValidator | ... |
| MatchValidator | ... |
| GroupValidator | ... |
