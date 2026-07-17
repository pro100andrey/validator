/// pro_validator is a dart package that provides a set of validators,
/// composable groups, and low-level string checkers.
library;

// Core: the Validator<T> base, ValidatorGroup composition and MatchValidator.
export 'src/core/match_validator.dart';
export 'src/core/validator.dart';
// Date validators.
export 'src/date/date_validator.dart';
// Whole-model validation (experimental).
export 'src/model/model_validator.dart';
// Number validators.
export 'src/number/number_validator.dart';
// Low-level string toolkit: patterns, isX checkers and String extensions.
export 'src/string/checkers.dart';
export 'src/string/extensions.dart';
export 'src/string/patterns.dart';
// Text validators.
export 'src/text/conditional_validator.dart';
export 'src/text/credit_card_validator.dart';
export 'src/text/file_extension_validator.dart';
export 'src/text/format_validator.dart';
export 'src/text/one_of_validator.dart';
export 'src/text/text_validator.dart';
