import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('EmailValidator: ignoreEmptyValues = true', () {
    const error = 'error';

    const validator = EmailValidator(
      error: error,
    );
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value', () {
      expect(validator(''), null);
    });
  });

  group('EmailValidator: ignoreEmptyValues = false', () {
    const error = 'error';

    const validator = EmailValidator(
      error: error,
    );

    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value', () {
      expect(validator(''), error);
    });
  });

  group('EmailValidator - valid email', () {
    const error = 'error';

    const validator = EmailValidator(
      error: error,
    );

    final validEmails = [
      'email@example.com',
      'firstname.lastname@example.com',
      'email@subdomain.example.com',
      'firstname+lastname@example.com',
      '"email"@example.com',
      '1234567890@example.com',
      'email@example-one.com',
      '_______@example.com',
      'email@example.name',
      'email@example.museum',
      'email@example.co.jp',
      'firstname-lastname@example.com'
    ];

    for (final email in validEmails) {
      test(email, () {
        expect(validator(email), null, reason: email);
      });
    }
  });

  group('EmailValidator - invalid email', () {
    const error = 'error';

    const validator = EmailValidator(
      error: error,
    );

    final invalidEmail = [
      'plainAddress',
      r'#@%^%#$@#$@#.com',
      '@example.com',
      'Joe Smith <email@example.com>',
      'email.example.com',
      'email@example@example.com',
      '.email@example.com',
      'email.@example.com',
      'email..email@example.com',
      'email@example.com (Joe Smith)',
      'email@example',
      'email@-example.com',
      'email@111.222.333.44444',
      'email@example..com',
      'Abc..123@example.com',
      'email@123.123.123.123',
      'email@[123.123.123.123]',
    ];

    for (final email in invalidEmail) {
      test(email, () {
        expect(
          validator(email),
          error,
          reason: email,
        );
      });
    }
  });
}
