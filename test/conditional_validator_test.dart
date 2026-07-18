import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('ConditionalValidator', () {
    test('runs inner validator when condition is true', () {
      final validator = ConditionalValidator(
        condition: (_) => true,
        validator: const RequiredValidator(error: 'required'),
      );
      expect(validator(''), 'required');
      expect(validator('x'), isNull);
    });

    test('skips inner validator when condition is false', () {
      final validator = ConditionalValidator(
        condition: (_) => false,
        validator: const RequiredValidator(error: 'required'),
      );
      expect(validator(''), isNull);
      expect(validator(null), isNull);
      // Even a non-empty value that would otherwise fail is valid when skipped.
      expect(validator('anything'), isNull);
    });

    test('condition can depend on the value', () {
      final validator = ConditionalValidator(
        condition: (value) => value != null && value.startsWith('a'),
        validator: const MinLengthValidator(min: 5, error: 'min'),
      );
      expect(validator('abc'), 'min');
      expect(validator('xbc'), isNull);
    });

    test('call and isValid agree when the inner skips empty', () {
      final validator = ConditionalValidator(
        condition: (_) => true,
        validator: const EmailValidator(error: 'e'),
      );
      expect(validator(''), isNull);
      expect(validator.isValid(''), isTrue);
    });

    test('composes inside a ValidatorGroup', () {
      final group = ValidatorGroup([
        const RequiredValidator(error: 'required'),
        ConditionalValidator(
          condition: (value) => value != null && value.startsWith('a'),
          validator: const MinLengthValidator(min: 5, error: 'min'),
        ),
      ]);
      expect(group(''), 'required');
      expect(group('abc'), 'min');
      expect(group('abcde'), isNull);
      expect(group('xyz'), isNull);
    });
  });
}
