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

    test('case-insensitive when configured', () {
      const v = OneOfValidator(
        values: ['USD'],
        error: 'error',
        caseSensitive: false,
      );
      expect(v('usd'), isNull);
    });
  });

  group('FileExtensionValidator', () {
    const validator = FileExtensionValidator(
      allowedExtensions: ['jpg', '.png'],
      error: 'error',
    );

    test('accepts allowed extension (case-insensitive)', () {
      expect(validator('avatar.PNG'), isNull);
      expect(validator('photo.jpg'), isNull);
    });

    test('rejects disallowed extension', () {
      expect(validator('report.pdf'), 'error');
    });

    test('rejects missing extension', () {
      expect(validator('README'), 'error');
      expect(validator('trailing.'), 'error');
    });

    test('supports multi-part extensions', () {
      const archive = FileExtensionValidator(
        allowedExtensions: ['tar.gz'],
        error: 'error',
      );
      expect(archive('backup.tar.gz'), isNull);
      expect(archive('backup.gz'), 'error');
      expect(archive('.tar.gz'), 'error');
    });
  });

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
    });

    test('condition can depend on the value', () {
      final validator = ConditionalValidator(
        condition: (value) => value != null && value.startsWith('a'),
        validator: const MinLengthValidator(min: 5, error: 'min'),
      );
      expect(validator('abc'), 'min');
      expect(validator('xbc'), isNull);
    });

    test('isValid agrees with call when inner skips empty', () {
      final validator = ConditionalValidator(
        condition: (_) => true,
        validator: const EmailValidator(error: 'e'),
      );
      expect(validator(''), isNull);
      expect(validator.isValid(''), isTrue);
    });
  });
}
