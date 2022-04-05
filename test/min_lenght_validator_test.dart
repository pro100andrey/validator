import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('MinLengthValidator:', () {
    const error = 'error';
    const minLength = 4;
    final validator = MinLengthValidator(minLength, error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
    });

    test('value.length == 1 (error)', () {
      expect(validator('1'), error);
    });
    test('value.length == 4', () {
      expect(validator('1234'), null);
    });

    test('value.length > 4 ', () {
      expect(validator('1234567890'), null);
    });
  });
}
