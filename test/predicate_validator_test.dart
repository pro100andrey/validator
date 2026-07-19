import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('PredicateValidator', () {
    final finite = PredicateValidator<num>(
      (v) => v.isFinite,
      error: 'error',
    );

    test('passing predicate returns null', () => expect(finite(1.5), isNull));
    test('failing predicate returns error', () {
      expect(finite(double.nan), 'error');
      expect(finite(double.infinity), 'error');
    });
    test('null is skipped by default', () => expect(finite(null), isNull));
    test('null fails when ignoreEmptyValues: false', () {
      final strict = PredicateValidator<num>(
        (v) => v.isFinite,
        error: 'error',
        ignoreEmptyValues: false,
      );
      expect(strict(null), 'error');
    });

    test('String predicate runs on blank input (null-only empty)', () {
      // Unlike text validators, only null counts as empty here.
      final noSpaces = PredicateValidator<String>(
        (s) => !s.contains(' '),
        error: 'error',
      );
      expect(noSpaces(''), isNull); // predicate ran and passed
      expect(noSpaces(' '), 'error'); // predicate ran and failed
      expect(noSpaces(null), isNull); // skipped
    });

    test('composes with & into a ValidatorGroup', () {
      final v =
          const MinValidator(min: 0, error: 'min') &
          PredicateValidator<num>((n) => n % 5 == 0, error: 'step');
      expect(v(10), isNull);
      expect(v(7), 'step');
      expect(v(-5), 'min');
    });
  });

  group('Patterns.toValidator', () {
    final slug = Patterns.slug.toValidator(error: 'error');

    test('valid value passes', () => expect(slug('my-first-post'), isNull));
    test('invalid value fails', () => expect(slug('Not a slug!'), 'error'));
    test('empty input is skipped like any text validator', () {
      expect(slug(null), isNull);
      expect(slug(''), isNull);
      expect(slug('   '), isNull);
    });
    test('ignoreEmptyValues: false rejects empty input', () {
      final strict = Patterns.slug.toValidator(
        error: 'error',
        ignoreEmptyValues: false,
      );
      expect(strict(''), 'error');
    });

    test('inherits the pattern case-sensitivity', () {
      final color = Patterns.hexColor.toValidator(error: 'error');
      expect(color.caseSensitive, isFalse);
      expect(color('#FF8800'), isNull);
      expect(color('#ff8800'), isNull);
    });

    test('works for formats without a named validator class', () {
      final iban = Patterns.iban.toValidator(error: 'error');
      expect(iban('DE89370400440532013000'), isNull);
      expect(iban('not-an-iban'), 'error');
    });
  });
}
