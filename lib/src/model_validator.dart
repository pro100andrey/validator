// This builder is a fluent DSL: its methods intentionally return `this` so
// checks can be chained, and the generic `check` method uses its type
// parameters only to *consume* values (never to expose them), so the two lints
// below are safe to relax for this file.
// ignore_for_file: avoid_returning_this, unsafe_variance
import 'package:meta/meta.dart';

import 'validator/validator.dart';

/// The outcome of validating a model: which field failed with which messages.
///
/// Keys are the `key` passed to [ModelValidator.ruleFor]; the value is every
/// failing message for that field, in declaration order. An empty map means the
/// model is valid.
@experimental
class ValidationResult {
  /// Constructs a result from a map of field key to failing messages.
  const ValidationResult(this.errors);

  /// Field key → the messages that failed for it.
  final Map<String, List<String>> errors;

  /// Whether every rule passed.
  bool get isValid => errors.isEmpty;

  /// The failing messages for [key], or an empty list if it passed.
  List<String> errorsFor(String key) => errors[key] ?? const [];

  /// The first failing message for [key], or `null` if it passed.
  ///
  /// Handy when the UI shows a single message per field.
  String? firstFor(String key) {
    final list = errorsFor(key);

    return list.isEmpty ? null : list.first;
  }
}

/// Validates a whole model [T]: field checks, cross-field rules, conditions and
/// rule-sets, reusing the package's value validators.
///
/// **Experimental** — the rule-building API may still change in a minor
/// release while it is being battle-tested.
///
/// Subclass it and declare rules in the constructor with [ruleFor]:
///
/// ```dart
/// class UserValidator extends ModelValidator<User> {
///   UserValidator() {
///     ruleFor('email')
///         .check((u) => u.email, const RequiredValidator(error: 'Required'))
///         .check((u) => u.email, const EmailValidator(error: 'Invalid'));
///
///     ruleFor('age')
///         .check((u) => u.age, const MinValidator(min: 18, error: '18+'));
///
///     ruleFor('confirm')
///         .must((u) => u.confirm == u.password, error: 'Passwords differ');
///
///     ruleFor('code')
///         .check((u) => u.code, const RequiredValidator(error: 'Required'))
///         .when((u) => u.wantsDiscount);
///
///     ruleFor('id')
///         .check((u) => u.id, const RequiredValidator(error: 'Required'))
///         .only('update');
///   }
/// }
///
/// final result = UserValidator().validate(user);          // all rules
/// final onUpdate = UserValidator().validate(user, ruleSet: 'update');
/// ```
@experimental
abstract class ModelValidator<T> {
  final List<_Rule<T>> _rules = [];

  /// Starts a rule for the field identified by [key] and returns a builder to
  /// attach checks, a condition and a rule-set to it.
  RuleBuilder<T> ruleFor(String key) {
    final rule = _Rule<T>(key);
    _rules.add(rule);

    return RuleBuilder<T>._(rule);
  }

  /// Runs the rules against [model], returning a [ValidationResult].
  ///
  /// Untagged rules always run. A rule tagged via [RuleBuilder.only] runs only
  /// when its tag equals [ruleSet]. A rule guarded by [RuleBuilder.when] /
  /// [RuleBuilder.unless] is skipped when the guard fails.
  ValidationResult validate(T model, {String? ruleSet}) {
    final errors = <String, List<String>>{};
    for (final rule in _rules) {
      if (!rule.runsIn(ruleSet) || !rule.guardPasses(model)) {
        continue;
      }
      for (final check in rule.checks) {
        final error = check(model);
        if (error != null) {
          (errors[rule.key] ??= <String>[]).add(error);
        }
      }
    }

    return ValidationResult(
      Map<String, List<String>>.unmodifiable({
        for (final entry in errors.entries)
          entry.key: List<String>.unmodifiable(entry.value),
      }),
    );
  }
}

/// A single field's rule: its checks, an optional guard and an optional
/// rule-set tag. Internal — built through [RuleBuilder].
class _Rule<T> {
  _Rule(this.key);

  final String key;
  final List<String? Function(T)> checks = [];
  bool Function(T)? guard;
  final Set<String> ruleSets = {};

  bool runsIn(String? set) =>
      ruleSets.isEmpty || (set != null && ruleSets.contains(set));

  bool guardPasses(T model) => guard?.call(model) ?? true;
}

/// Fluent builder for a single field's rule (see [ModelValidator.ruleFor]).
@experimental
class RuleBuilder<T> {
  RuleBuilder._(this._rule);

  final _Rule<T> _rule;

  /// Runs a [validator] against the value returned by [selector].
  ///
  /// Works for any value type: text (`EmailValidator`, `RequiredValidator`),
  /// numbers (`MinValidator`), dates (`AfterValidator`), … — anything
  /// extending `Validator<V>`.
  RuleBuilder<T> check<V extends Object>(
    V? Function(T) selector,
    Validator<V> validator,
  ) {
    _rule.checks.add((model) => validator(selector(model)));

    return this;
  }

  /// Adds a cross-field / arbitrary check over the whole model.
  ///
  /// Reports [error] when [predicate] returns `false`.
  RuleBuilder<T> must(bool Function(T) predicate, {required String error}) {
    _rule.checks.add((model) => predicate(model) ? null : error);

    return this;
  }

  /// Runs this rule only when [condition] holds. Combines (AND) with any
  /// existing guard.
  RuleBuilder<T> when(bool Function(T) condition) {
    final previous = _rule.guard;
    _rule.guard = previous == null
        ? condition
        : (model) => previous(model) && condition(model);

    return this;
  }

  /// Runs this rule only when [condition] does **not** hold.
  RuleBuilder<T> unless(bool Function(T) condition) =>
      when((model) => !condition(model));

  /// Adds this rule to a rule-set; it then runs only when
  /// [ModelValidator.validate] is called with a matching `ruleSet`. Call it
  /// more than once to include the rule in several rule-sets.
  RuleBuilder<T> only(String ruleSet) {
    _rule.ruleSets.add(ruleSet);

    return this;
  }
}
