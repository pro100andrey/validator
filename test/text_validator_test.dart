import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('TextValidator -', () {
    test('RequiredValidator', () {
      const error = 'Value cannot be empty';
      const config = ValidatorConfig(valueMode: EmptyValueMode.invalid);

      expect(
        const RequiredValidator(error: error)(null),
        isNull,
        reason: 'Should be null',
      );

      expect(
        const RequiredValidator(error: error)(''),
        isNull,
        reason: 'Should be null',
      );

      expect(
        const RequiredValidator(error: error, config: config)(null),
        equals(error),
        reason: 'Should be - $error',
      );

      expect(
        const RequiredValidator(error: error, config: config)(''),
        equals(error),
        reason: 'Should be - $error',
      );
    });
  });
}
