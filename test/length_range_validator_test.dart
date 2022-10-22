import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('LengthRangeValidator:', () {
    const error = 'error';
    const minimum = 2;
    const maximum = 10;
    const validator = LengthRangeValidator(
      min: minimum,
      max: maximum,
      error: error,
    );
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
    });

    test('min:$minimum max:$maximum current length - 1 (error)', () {
      expect(validator('1'), error);
    });

    test('min:$minimum max:$maximum current length - 2', () {
      expect(validator('12'), null);
    });

    test('min:$minimum max:$maximum current length - 10', () {
      expect(validator('1234567890'), null);
    });

    test('min:$minimum max:$maximum current length - 11 (error)', () {
      expect(validator('1234567890a'), error);
    });
  });
}
