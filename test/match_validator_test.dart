import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('MatchValidator', () {
    const validator = MatchValidator(error: 'error');

    test('equal literals pass', () {
      expect(validator('secret', 'secret'), isNull);
    });

    test('different values fail', () {
      expect(validator('secret', 'other'), 'error');
    });

    // Regression: previously implemented with `identical`, which fails for
    // equal-but-distinct runtime strings (e.g. two form fields).
    test('equal runtime-built strings pass', () {
      final a = ['sec', 'ret'].join();
      final b = 'secret'.split('').join();
      expect(identical(a, b), isFalse, reason: 'strings are distinct objects');
      expect(validator(a, b), isNull);
    });

    test('both null pass', () => expect(validator(null, null), isNull));

    test('works for non-string values', () {
      expect(validator(1, 1), isNull);
      expect(validator(1, 2), 'error');
    });
  });
}
