import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('RequiredValidator:', () {
    const error = 'error';
    const validator = RequiredValidator(
      error: error,
    );
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), null);
    });

    test('any value set', () {
      expect(validator('any'), null);
    });
  });
}
