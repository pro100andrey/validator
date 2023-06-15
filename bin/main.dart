// ignore_for_file: avoid_print

import 'package:pro_validator/pro_validator.dart';

void main() {
  const emailValidator = MultiValidator(
    validators: [
      RequiredValidator(
        error: 'Required field',
      ),
      EmailValidator(error: 'Invalid email'),
    ],
  );

  print('valid email: ${emailValidator(null)}');
  print('valid email ${emailValidator('mail@mail.com')}');
  print('invalid email: ${emailValidator('')}');
  print('invalid email: ${emailValidator('mail@com')}');

  const passwordValidator = MultiValidator(
    validators: [
      RequiredValidator(
        error: 'Required field',
      ),
      MinLengthValidator(min: 8, error: 'Min length 8'),
      HasUppercaseValidator(error: 'Must contain at least one uppercase'),
      HasLowercaseValidator(error: 'Must contain at least one lowercase'),
    ],
  );

  print('valid password ${passwordValidator(null)}');
  print('empty password validation ${passwordValidator('')}');
  print('min length password validation ${passwordValidator('1232')}');
  print('invalid password validation ${passwordValidator('12345678')}');
  print('invalid password validation ${passwordValidator('12345678A')}');
  print('valid password validation ${passwordValidator('a12345678A')}');

  final matchValidator = MatchValidator(error: 'Do not match');

  print('match validation ${matchValidator('a', 'b')}');
}
