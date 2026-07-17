import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  const validator = ValidatorGroup([
    RequiredValidator(error: 'required'),
    MinLengthValidator(min: 4, error: 'min'),
    HasANumberValidator(error: 'number'),
  ]);

  group('ValidatorGroup.call', () {
    test('returns first error in order', () {
      expect(validator(null), 'required');
      expect(validator('ab'), 'min');
      expect(validator('abcd'), 'number');
    });

    test('returns null when all pass', () {
      expect(validator('abc1'), isNull);
    });
  });

  group('ValidatorGroup.errors (collect-all)', () {
    test('returns every failing message', () {
      expect(validator('ab'), 'min');
      expect(validator.errors('ab'), ['min', 'number']);
    });

    test('empty list when valid', () {
      expect(validator.errors('abc1'), isEmpty);
    });
  });

  group('& composition operator', () {
    final composed =
        const RequiredValidator(error: 'required') &
        const MinLengthValidator(min: 4, error: 'min') &
        const HasANumberValidator(error: 'number');

    test('builds an equivalent ValidatorGroup', () {
      expect(composed, isA<ValidatorGroup<String>>());
      expect(composed.validators, hasLength(3));
      expect(composed(null), 'required');
      expect(composed('abcd'), 'number');
      expect(composed('abc1'), isNull);
    });
  });

  group('typed groups share the same machinery', () {
    test('num group composes and skips null', () {
      final adult =
          const MinValidator(min: 18, error: 'young') &
          const MaxValidator(max: 120, error: 'old');
      expect(adult, isA<ValidatorGroup<num>>());
      expect(adult(10), 'young');
      expect(adult(200), 'old');
      expect(adult(30), isNull);
      expect(adult(null), isNull);
    });

    test('date group composes', () {
      final range =
          AfterValidator(dateTime: DateTime(2000), error: 'after') &
          BeforeValidator(dateTime: DateTime(2030), error: 'before');
      expect(range, isA<ValidatorGroup<DateTime>>());
      expect(range(DateTime(2020)), isNull);
      expect(range(DateTime(1990)), 'after');
    });
  });
}
