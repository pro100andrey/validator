import 'text_validator.dart';

/// Ensures the value (a file name or path) ends with one of the
/// [allowedExtensions].
///
/// Extensions may be given with or without a leading dot and are matched
/// case-insensitively. Multi-part extensions such as `tar.gz` are supported. A
/// value with no extension (or no base name before the dot) is rejected.
///
/// Example:
/// ```dart
/// const image = FileExtensionValidator(
///   allowedExtensions: ['jpg', 'jpeg', 'png'],
///   error: 'Only JPG and PNG images are allowed',
/// );
/// image('avatar.PNG'); // null
/// image('report.pdf'); // 'Only JPG and PNG images are allowed'
/// ```
class FileExtensionValidator extends TextValidator {
  const FileExtensionValidator({
    required this.allowedExtensions,
    required super.error,
    super.ignoreEmptyValues,
  });

  /// Accepted extensions, with or without a leading dot (case-insensitive).
  final List<String> allowedExtensions;

  @override
  bool isValid(String value) {
    final lower = value.toLowerCase();

    return allowedExtensions.any((allowed) {
      final normalized =
          (allowed.startsWith('.') ? allowed.substring(1) : allowed)
              .toLowerCase();

      // Require a non-empty extension and a non-empty base name before it, so
      // "backup.tar.gz" matches "tar.gz" while ".png" (no name) is rejected.
      return normalized.isNotEmpty &&
          lower.length > normalized.length + 1 &&
          lower.endsWith('.$normalized');
    });
  }
}
