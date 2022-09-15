import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('MaxLengthValidator:', () {
    const error = 'error';
    const max = 10;
    const validator = MaxLengthValidator(max: max, error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value', () {
      expect(validator(''), null);
    });

    test('value.length < 10', () {
      expect(validator('123456789'), null);
    });

    test('value.length == 10', () {
      expect(validator('1234567890'), null);
    });

    test('value.length > 10 (error)', () {
      expect(validator('12345678901'), error);
    });
  });
}
