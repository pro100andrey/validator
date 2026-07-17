import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  group('CreditCardValidator', () {
    const validator = CreditCardValidator(error: 'error');

    test('valid Visa (spaces stripped)', () {
      expect(validator('4111 1111 1111 1111'), isNull);
    });

    test('valid MasterCard (dashes stripped)', () {
      expect(validator('5500-0000-0000-0004'), isNull);
    });

    // Regression: regex alone accepts this; the Luhn check rejects it.
    test('rejects wrong check digit', () {
      expect(validator('4111 1111 1111 1112'), 'error');
    });

    test('rejects non-card digits', () {
      expect(validator('1234 5678 9012 3456'), 'error');
    });

    test('empty is skipped', () => expect(validator(''), isNull));
  });

  group('isLuhn', () {
    test('valid checksums', () {
      expect(isLuhn('79927398713'), isTrue);
      expect(isLuhn('4111111111111111'), isTrue);
    });

    test('invalid checksum', () {
      expect(isLuhn('79927398710'), isFalse);
    });

    test('empty and non-digits are invalid', () {
      expect(isLuhn(''), isFalse);
      expect(isLuhn('12a4'), isFalse);
    });

    test('String extension', () {
      expect('79927398713'.isLuhn, isTrue);
    });
  });
}
