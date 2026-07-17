import '../core/validator.dart';

/// Ensures the value is strictly after [dateTime].
class AfterValidator extends Validator<DateTime> {
  const AfterValidator({
    required this.dateTime,
    required super.error,
    super.ignoreEmptyValues,
  });

  /// The value must occur after this instant.
  final DateTime dateTime;

  @override
  bool isValid(DateTime value) => value.isAfter(dateTime);
}

/// Ensures the value is strictly before [dateTime].
class BeforeValidator extends Validator<DateTime> {
  const BeforeValidator({
    required this.dateTime,
    required super.error,
    super.ignoreEmptyValues,
  });

  /// The value must occur before this instant.
  final DateTime dateTime;

  @override
  bool isValid(DateTime value) => value.isBefore(dateTime);
}

/// Ensures the value falls within the inclusive range [[start], [end]].
class DateRangeValidator extends Validator<DateTime> {
  const DateRangeValidator({
    required this.start,
    required this.end,
    required super.error,
    super.ignoreEmptyValues,
  });

  final DateTime start;
  final DateTime end;

  @override
  bool isValid(DateTime value) =>
      !value.isBefore(start) && !value.isAfter(end);
}

/// Ensures the value is in the past relative to [clock].
///
/// [clock] supplies "now" and defaults to [DateTime.now]. Inject a fixed clock
/// in tests for deterministic results.
class PastValidator extends Validator<DateTime> {
  PastValidator({
    required super.error,
    super.ignoreEmptyValues,
    this.clock = DateTime.now,
  });

  /// Returns the current instant the value is compared against.
  final DateTime Function() clock;

  @override
  bool isValid(DateTime value) => value.isBefore(clock());
}

/// Ensures the value is in the future relative to [clock].
///
/// [clock] supplies "now" and defaults to [DateTime.now]. Inject a fixed clock
/// in tests for deterministic results.
class FutureValidator extends Validator<DateTime> {
  FutureValidator({
    required super.error,
    super.ignoreEmptyValues,
    this.clock = DateTime.now,
  });

  /// Returns the current instant the value is compared against.
  final DateTime Function() clock;

  @override
  bool isValid(DateTime value) => value.isAfter(clock());
}
