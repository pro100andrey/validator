import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('HasANumberValidator:', () {
    const error = 'error';
    const validator = HasANumberValidator(error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), null);
    });

    test('without number (error)', () {
      expect(validator('abcde'), error);
    });

    test('one number', () {
      expect(validator('abcde1'), null);
    });

    test('a few numbers', () {
      expect(validator('0abcde12345'), null);
    });
  });
}
