import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('LengthRangeValidator:', () {
    const error = 'error';
    const minimum = 2;
    const maximum = 10;
    const validator = NumRangeValidator(
      min: minimum,
      max: maximum,
      error: error,
    );

    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value', () {
      expect(validator(''), null);
    });

    test('min:$minimum max:$maximum current - 1 (error)', () {
      expect(validator('1'), error);
    });

    test('min:$minimum max:$maximum current - 2', () {
      expect(validator('2'), null);
    });

    test('min:$minimum max:$maximum current - 10', () {
      expect(validator('10'), null);
    });

    test('min:$minimum max:$maximum current - 11 (error)', () {
      expect(validator('11'), error);
    });
  });
}
