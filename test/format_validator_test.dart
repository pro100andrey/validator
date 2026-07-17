import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('EmailValidator', () {
    const validator = EmailValidator(error: 'error');

    test('valid emails', () {
      expect(validator('user@mail.com'), isNull);
      expect(validator('user.name+tag@sub.example.co'), isNull);
    });

    test('invalid emails', () {
      expect(validator('mail@com'), 'error');
      expect(validator('plainaddress'), 'error');
      expect(validator('a@b'), 'error');
    });
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
