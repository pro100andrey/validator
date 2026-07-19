import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
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

    test('empty input is skipped', () => expect(validator(''), isNull));

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
}
