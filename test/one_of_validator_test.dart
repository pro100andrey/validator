import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('OneOfValidator', () {
    const validator = OneOfValidator(
      values: ['USD', 'EUR', 'UAH'],
      error: 'error',
    );

    test('accepts a listed value', () => expect(validator('EUR'), isNull));
    test('rejects an unlisted value', () => expect(validator('GBP'), 'error'));
    test('is case-sensitive by default', () {
      expect(validator('eur'), 'error');
    });
    test('empty input is skipped', () => expect(validator(''), isNull));

    test('case-insensitive when configured', () {
      const v = OneOfValidator(
        values: ['USD'],
        error: 'error',
        caseSensitive: false,
      );
      expect(v('usd'), isNull);
      expect(v('USD'), isNull);
    });
  });
}
