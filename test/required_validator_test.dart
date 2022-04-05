import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('RequiredValidator:', () {
    const error = 'error';
    final validator = RequiredValidator(error: error);
    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value (error)', () {
      expect(validator(''), error);
    });

    test('any value set', () {
      expect(validator('any'), null);
    });
  });
}
