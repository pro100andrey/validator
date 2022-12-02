import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('MinLengthValidator:', () {
    const error = 'error';
    const min = 4;
    const validator = MinLengthValidator(min: min, error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), null);
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
