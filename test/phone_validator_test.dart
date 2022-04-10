import 'package:test/test.dart';
import 'package:validator/validator.dart';

void main() {
  group('PhoneValidator:', () {
    const error = 'error';

    final validator = PhoneValidator(
      error: error,
    );

    test('null value', () {
      expect(validator(null), null);
    });

    test('empty value', () {
      expect(validator(''), null);
    });

    final validPhones = [
      '1800 801 920',
      '+44 20 8759 9036',
      '+1 800 444 4444',
      '+1 213 621 0002',
      '+380 (50) 688-88-88',
      '+380506888888',
      '800 5551212 ext3333',
      '+1800 555 1212 extension65432'
    ];

    group('Valid Phones', () {
      for (final phone in validPhones) {
        test(phone, () {
          expect(validator(phone), null, reason: phone);
        });
      }
    });

    final invalidPhones = [
      'plainphonenumber',
      '+380gd506888888',
    ];
    group('invalid emails', () {
      for (final phone in invalidPhones) {
        test(phone, () {
          expect(
            validator(phone),
            error,
            reason: phone,
          );
        });
      }
    });
  });
}
