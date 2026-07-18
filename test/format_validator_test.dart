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

    const validPhones = [
      '+1234567890',
      '123-456-7890',
      '+380506888888',
      '555 123 4567',
    ];

    // Documents the pattern's real boundary: it accepts a single optional
    // country code + a 3-3-4 grouping, so spaced/parenthesised international
    // formats are NOT matched. These are pinned so a pattern change is noticed.
    const invalidPhones = [
      'abc-def-ghij',
      '+44 20 8759 9036', // multi-group spacing not supported
      '1800 801 920',
      '+380 (50) 688-88-88',
    ];

    for (final phone in validPhones) {
      test('accepts $phone', () => expect(validator(phone), isNull));
    }
    for (final phone in invalidPhones) {
      test('rejects $phone', () => expect(validator(phone), 'error'));
    }
  });

  group('UrlValidator', () {
    const validator = UrlValidator(error: 'error');

    const validUrls = [
      'https://example.com',
      'http://www.example.com',
      'www.example.com',
    ];

    const invalidUrls = [
      'not a url',
      'example.com', // missing protocol/www prefix
      'go to www.example.com', // must be the whole value, not merely contain
    ];

    for (final url in validUrls) {
      test('accepts $url', () => expect(validator(url), isNull));
    }
    for (final url in invalidUrls) {
      test('rejects $url', () => expect(validator(url), 'error'));
    }
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
