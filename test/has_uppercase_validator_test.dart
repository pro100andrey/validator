import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('HasUppercaseValidator:', () {
    const error = 'error';
    const validator = HasUppercaseValidator(error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
    });

    test('without uppercase (error)', () {
      expect(validator('1234567890abc'), error);
    });

    test('one uppercase', () {
      expect(validator('A1234567890abc'), null);
    });

    test('a few uppercases', () {
      expect(validator('1234567890abcABC'), null);
    });
  });
}
