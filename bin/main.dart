// Demonstrates the main features of pro_validator.
//
// ignore_for_file: avoid_print — this is a runnable example.

import 'package:pro_validator/pro_validator.dart';

void main() {
  // Compose validators with the `&` operator. Only `RequiredValidator`
  // fails on empty input; format validators skip it.
  final emailValidator =
      const RequiredValidator(error: 'Required field') &
      const EmailValidator(error: 'Invalid email');

  print('null email: ${emailValidator(null)}'); // Required field
  print('empty email: ${emailValidator('')}'); // Required field
  print('bad email: ${emailValidator('mail@com')}'); // Invalid email
  print('good email: ${emailValidator('mail@mail.com')}'); // null

  // A group can also report every failing rule at once.
  const password = ValidatorGroup([
    RequiredValidator(error: 'Required field'),
    MinLengthValidator(min: 8, error: 'Min length 8'),
    HasUppercaseValidator(error: 'Need an uppercase letter'),
    HasANumberValidator(error: 'Need a number'),
  ]);

  print('first error: ${password('abc')}'); // Min length 8
  print('all errors: ${password.errors('abc')}'); // [Min length 8, ...]
  print('valid password: ${password('Abcdef12')}'); // null

  // Match two values (e.g. password confirmation).
  const match = MatchValidator(error: 'Passwords do not match');
  print('match: ${match('secret', 'secret')}'); // null
  print('mismatch: ${match('secret', 'other')}'); // Passwords do not match

  // Low-level checkers and String extensions are exported too.
  // Note: the `isCreditCard` checker expects digits only. The
  // `CreditCardValidator` strips spaces/dashes and also runs the Luhn check.
  print('card is valid: ${'4111111111111111'.isCreditCard}');
  print('is email: ${'user@mail.com'.isEmail}');
  print('isLuhn(79927398713): ${isLuhnValid('79927398713')}');
}
