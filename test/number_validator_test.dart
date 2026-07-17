import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('MinValidator', () {
    const v = MinValidator(min: 10, error: 'error');

    test('below fails', () => expect(v(9), 'error'));
    test('equal passes', () => expect(v(10), isNull));
    test('above passes', () => expect(v(11), isNull));
    test('null is skipped', () => expect(v(null), isNull));
    test('null fails when ignoreEmptyValues: false', () {
      const strict = MinValidator(
        min: 10,
        error: 'error',
        ignoreEmptyValues: false,
      );
      expect(strict(null), 'error');
    });
  });

  group('MaxValidator', () {
    const v = MaxValidator(max: 10, error: 'error');

    test('above fails', () => expect(v(11), 'error'));
    test('equal passes', () => expect(v(10), isNull));
  });

  group('BetweenValidator', () {
    const v = BetweenValidator(min: 1, max: 10, error: 'error');

    test('below fails', () => expect(v(0), 'error'));
    test('above fails', () => expect(v(11), 'error'));
    test('boundaries pass', () {
      expect(v(1), isNull);
      expect(v(10), isNull);
    });
  });

  group('sign', () {
    test('PositiveValidator', () {
      const v = PositiveValidator(error: 'error');
      expect(v(1), isNull);
      expect(v(0), 'error');
      expect(v(-1), 'error');
    });

    test('NegativeValidator', () {
      const v = NegativeValidator(error: 'error');
      expect(v(-1), isNull);
      expect(v(0), 'error');
    });
  });

  group('MultipleOfValidator', () {
    const v = MultipleOfValidator(factor: 3, error: 'error');

    test('multiple passes', () => expect(v(9), isNull));
    test('non-multiple fails', () => expect(v(10), 'error'));
    test('factor 0 is invalid, not a crash', () {
      const z = MultipleOfValidator(factor: 0, error: 'error');
      expect(z(5), 'error');
    });
    test('tolerance handles decimal factors', () {
      const decimals = MultipleOfValidator(
        factor: 0.1,
        error: 'error',
        tolerance: 1e-9,
      );
      expect(decimals(0.3), isNull); // exact `%` would wrongly fail this
      expect(decimals(0.35), 'error');
    });
  });

  group('Even/Odd', () {
    test('EvenValidator', () {
      const v = EvenValidator(error: 'error');
      expect(v(4), isNull);
      expect(v(-4), isNull);
      expect(v(3), 'error');
      expect(v(4.5), 'error');
    });

    test('OddValidator', () {
      const v = OddValidator(error: 'error');
      expect(v(3), isNull);
      expect(v(-3), isNull);
      expect(v(4), 'error');
      expect(v(4.5), 'error');
    });
  });

  group('composition with &', () {
    test('reports the first failing validator', () {
      final adult = const MinValidator(min: 18, error: 'young') &
          const MaxValidator(max: 120, error: 'old');
      expect(adult(10), 'young');
      expect(adult(200), 'old');
      expect(adult(30), isNull);
    });

    test('chains three and collects all errors', () {
      final v = const MinValidator(min: 0, error: 'min') &
          const MaxValidator(max: 10, error: 'max') &
          const EvenValidator(error: 'even');
      expect(v.validators, hasLength(3));
      expect(v(5), 'even');
      expect(v(4), isNull);
      expect(v.errors(-3), ['min', 'even']);
    });

    test('null is skipped through the group', () {
      final v = const MinValidator(min: 18, error: 'young') &
          const PositiveValidator(error: 'pos');
      expect(v(null), isNull);
    });
  });
}
