import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('EmailValidator', () {
    const validator = EmailValidator(error: 'error');

    const validEmails = [
      'email@example.com',
      'firstname.lastname@example.com',
      'email@subdomain.example.com',
      'firstname+lastname@example.com',
      '1234567890@example.com',
      'email@example-one.com',
      '_______@example.com',
      'email@example.name',
      'email@example.museum',
      'email@example.co.jp',
      'firstname-lastname@example.com',
      'user.name+tag@sub.example.co',
    ];

    const invalidEmails = [
      'plainaddress',
      'mail@com',
      'a@b',
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
      'email@example..com',
      'Abc..123@example.com',
      'email@[123.123.123.123]',
    ];

    for (final email in validEmails) {
      test('accepts $email', () => expect(validator(email), isNull));
    }
    for (final email in invalidEmails) {
      test('rejects $email', () => expect(validator(email), 'error'));
    }
  });

  group('PhoneValidator', () {
    const validator = PhoneValidator(error: 'error');

    test('valid phones', () {
      expect(validator('+1234567890'), isNull);
      expect(validator('123-456-7890'), isNull);
    });

    test('invalid phones', () {
      expect(validator('abc-def-ghij'), 'error');
    });
  });

  group('UrlValidator', () {
    const validator = UrlValidator(error: 'error');

    test('valid urls', () {
      expect(validator('https://example.com'), isNull);
      expect(validator('www.example.com'), isNull);
    });

    test('invalid urls', () {
      expect(validator('not a url'), 'error');
      // Must be the whole value, not merely contain a URL.
      expect(validator('go to www.example.com'), 'error');
    });
  });

  group('PatternValidator', () {
    test('matches custom pattern', () {
      const hex = PatternValidator(
        pattern: r'^#[0-9a-fA-F]{6}$',
        error: 'error',
      );
      expect(hex('#ff8800'), isNull);
      expect(hex('ff8800'), 'error');
    });

    test('respects caseSensitive flag', () {
      const v = PatternValidator(
        pattern: r'^abc$',
        error: 'error',
        caseSensitive: false,
      );
      expect(v('ABC'), isNull);
    });

    test('fromRegExp preserves flags beyond case-sensitivity', () {
      // \p{L} + unicode: a flag the String constructor can't express.
      final letters = PatternValidator.fromRegExp(
        RegExp(r'^\p{L}+$', unicode: true),
        error: 'error',
      );
      expect(letters('Ärzte'), isNull);
      expect(letters('abc123'), 'error');
      // Case-sensitivity is taken from the RegExp itself.
      final ci = PatternValidator.fromRegExp(
        RegExp(r'^abc$', caseSensitive: false),
        error: 'error',
      );
      expect(ci('ABC'), isNull);
      expect(ci.caseSensitive, isFalse);
    });
  });
}
