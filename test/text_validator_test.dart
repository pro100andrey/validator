import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('RequiredValidator', () {
    const validator = RequiredValidator(error: 'error');

    test('fails on null', () => expect(validator(null), 'error'));
    test('fails on empty', () => expect(validator(''), 'error'));
    test('fails on whitespace', () => expect(validator('   '), 'error'));
    test('passes on text', () => expect(validator('a'), isNull));
  });

  group('empty/null handling for format validators', () {
    const email = EmailValidator(error: 'error');

    test('null is treated as valid (skip)', () => expect(email(null), isNull));
    test('empty is treated as valid (skip)', () => expect(email(''), isNull));
    test('whitespace-only is treated as valid (skip)', () {
      expect(email('   '), isNull);
    });
    test('non-empty invalid still fails', () {
      expect(email('nope'), 'error');
    });

    test('ignoreEmptyValues: false rejects empty input', () {
      const strict = EmailValidator(error: 'error', ignoreEmptyValues: false);
      expect(strict(''), 'error');
      expect(strict(null), 'error');
      expect(strict('   '), 'error');
    });
  });

  group('MinLengthValidator', () {
    const validator = MinLengthValidator(min: 3, error: 'error');

    test('too short fails', () => expect(validator('ab'), 'error'));
    test('exact passes', () => expect(validator('abc'), isNull));
    test('longer passes', () => expect(validator('abcd'), isNull));
    test('empty is skipped', () => expect(validator(''), isNull));
  });

  group('MaxLengthValidator', () {
    const validator = MaxLengthValidator(max: 3, error: 'error');

    test('too long fails', () => expect(validator('abcd'), 'error'));
    test('exact passes', () => expect(validator('abc'), isNull));
    test('counts characters, not UTF-16 code units', () {
      const single = MaxLengthValidator(max: 1, error: 'error');
      expect(single('😀'), isNull);
    });
  });

  group('LengthRangeValidator', () {
    const validator = LengthRangeValidator(min: 2, max: 4, error: 'error');

    test('below range fails', () => expect(validator('a'), 'error'));
    test('above range fails', () => expect(validator('abcde'), 'error'));
    test('in range passes', () => expect(validator('abc'), isNull));
  });

  group('NumRangeValidator', () {
    const validator = NumRangeValidator(min: 1, max: 10, error: 'error');

    test('below range fails', () => expect(validator('0'), 'error'));
    test('above range fails', () => expect(validator('11'), 'error'));
    test('non-numeric fails', () => expect(validator('abc'), 'error'));
    test('in range passes', () => expect(validator('5'), isNull));
    test(
      'trims surrounding whitespace',
      () => expect(validator(' 5 '), isNull),
    );
  });

  group('character validators', () {
    test('HasUppercaseValidator', () {
      const v = HasUppercaseValidator(error: 'error');
      expect(v('abc'), 'error');
      expect(v('aBc'), isNull);
      // Unicode-aware: a non-ASCII uppercase letter counts.
      expect(v('ärzte'), 'error');
      expect(v('Ärzte'), isNull);
    });

    test('HasLowercaseValidator', () {
      const v = HasLowercaseValidator(error: 'error');
      expect(v('ABC'), 'error');
      expect(v('ABc'), isNull);
      // Unicode-aware: a non-ASCII lowercase letter counts.
      expect(v('ÄÖÜ'), 'error');
      expect(v('ÄÖü'), isNull);
    });

    test('HasANumberValidator', () {
      const v = HasANumberValidator(error: 'error');
      expect(v('abc'), 'error');
      expect(v('ab1'), isNull);
    });
  });
}
