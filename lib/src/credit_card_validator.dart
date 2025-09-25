import 'string/checkers.dart';
import 'text_validator.dart';

class CreditCardValidator extends TextValidator {
  const CreditCardValidator({
    required super.error,
  });

  @override
  bool isValid(String value) {
    final sanitized = value.replaceAll(RegExp('[^0-9]+'), '');

    return isCreditCard(sanitized);
  }
}
