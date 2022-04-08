import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('HasLowercaseValidator:', () {
    const error = 'error';
    final validator = HasLowercaseValidator(error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
    });

    test('without lowercase (error)', () {
      expect(validator('1234567890ABC'), error);
    });

    test('one lowercase', () {
      expect(validator('A1234567890a'), null);
    });

    test('a few lowercase', () {
      expect(validator('ab1234567890abcABC'), null);
    });
  });
}
