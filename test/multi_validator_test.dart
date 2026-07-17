import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  const validator = MultiValidator(
    validators: [
      RequiredValidator(error: 'required'),
      MinLengthValidator(min: 4, error: 'min'),
      HasANumberValidator(error: 'number'),
    ],
  );

  group('MultiValidator.call', () {
    test('returns first error in order', () {
      expect(validator(null), 'required');
      expect(validator('ab'), 'min');
      expect(validator('abcd'), 'number');
    });

    test('returns null when all pass', () {
      expect(validator('abc1'), isNull);
    });
  });

  group('MultiValidator.errors (collect-all)', () {
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

    test('builds an equivalent MultiValidator', () {
      expect(composed, isA<MultiValidator>());
      expect(composed.validators, hasLength(3));
      expect(composed(null), 'required');
      expect(composed('abcd'), 'number');
      expect(composed('abc1'), isNull);
    });
  });
}
