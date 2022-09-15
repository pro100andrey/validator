import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('HasANumberValidator:', () {
    const error = 'error';
    const validator = HasANumberValidator(error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
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
