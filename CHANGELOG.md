# Changelog

## 3.0.0

Major redesign. One deep core, typed validators for numbers and dates, a
composition story that works for every value type, and an experimental
whole-model validation layer. The library is split into focused modules
(`core` / `text` / `number` / `date` / `model` / `string`).

### Breaking changes

* **One base class.** Every validator now extends `Validator<T>`, which
  handles empty input once: `call(T?)` skips `null` (and, for text, blank
  strings) when `ignoreEmptyValues` is `true` — the default. Concrete
  validators implement `isValid` only for real, non-empty values.
* `ignoreEmptyValues: false` now uniformly means **"empty input is an
  error"**. Previously text validators ran `isValid` on the empty string, so
  e.g. a strict `MaxLengthValidator` could accept `''`.
* `MultiValidator` is replaced by `ValidatorGroup<T>`, which groups
  validators of *any* one type:
  `MultiValidator(validators: [...])` → `ValidatorGroup([...])`.
  `errors()` and the `&` operator work as before — and now also for
  `num`/`DateTime` validators.
* `MatchValidator` now compares values with `==` instead of `identical`, so
  two equal runtime strings (e.g. two form fields) correctly match. Its
  signature is `call(Object?, Object?)`.
* `RequiredValidator` now correctly fails on empty and `null` input
  (previously it was short-circuited and returned `null`).
* `MultiValidator.call` returned the failing validator's re-read `error`;
  `ValidatorGroup.call` returns the failing validator's actual result.

### Added

* **Number validators** (`Validator<num>`): `MinValidator`, `MaxValidator`,
  `RangeValidator`, `PositiveValidator`, `NegativeValidator`,
  `MultipleOfValidator` (with float `tolerance`), `EvenValidator`,
  `OddValidator`.
* **Date validators** (`Validator<DateTime>`): `AfterValidator`,
  `BeforeValidator`, `DateRangeValidator`, `PastValidator`,
  `FutureValidator` (with an injectable `clock` for deterministic tests).
* **Whole-model validation** (experimental): `ModelValidator<T>` with
  `ruleFor(key)`, chained `.check(selector, validator)`, cross-field
  `.must(predicate)`, conditions `.when`/`.unless` and rule-sets `.only`.
  Returns a `ValidationResult` keyed by field.
* `ValidatorGroup<T>` + the `&` operator to compose validators of any type
  without building a list manually.
* `PredicateValidator<T>` — build a validator from any `bool Function(T)`
  without declaring a class.
* `Patterns.x.toValidator(error: ...)` — turn any of the 40+ built-in
  `Patterns` entries into a `PatternValidator`, reusing its compiled regex.
* `CreditCardValidator` — scheme regex **plus** Luhn checksum.
* `OneOfValidator`, `FileExtensionValidator`, `ConditionalValidator`.
* `PatternValidator.fromRegExp` to reuse a pre-compiled `RegExp` (any flags);
  string-built patterns are compiled once and cached.
* Public `Patterns` enum, `isX(String)` checkers and `String` extensions
  (`'x'.isEmail`, `isLuhn(...)`, etc.), now exported from the package.

### Fixed

* `emailRFC5322` no longer backtracks catastrophically (ReDoS). Its domain
  grammar wrongly allowed a `.` **inside** a label while also using `.` as the
  label separator, so an input like `a@a.a.a.…` blew up exponentially (~22s at
  52 chars). Dots now only separate labels; matching is linear.
* `iso8601DateTime` now accepts a valid offset-less timestamp (a local
  `DateTime.toIso8601String()`) and basic/hour-only offsets (`+0200`, `-05`);
  previously it required a `Z` or extended (`+02:00`) offset and rejected the
  rest.
* `hexColor` now requires the leading `#`, so ordinary hex-lettered words
  (`"decade"`, `"facade"`) no longer validate as colors.
* `decimal` now rejects a trailing dot with no fraction (`"123."`).
* Corrected swapped latitude/longitude doc comments and email pattern docs.

### Removed

* The free-function `hasMatch(pattern, input)` helper (it recompiled the regex
  on every call and duplicated `Patterns` / `PatternValidator`). Use
  `Patterns.x.hasMatch`, `PatternValidator`, or a `RegExp` directly.

## 2.0.1

* Update dependencies.

## 2.0.0

* Bump sdk version to ^3.0.0.

## 1.1.1

* Fix - skip checks if value is null.

## 1.1.0

* Breaking changes - ignoreEmptyValues true by default.

## 1.0.1

* Added access to ignoreEmptyValues field.

## 1.0.0+1

* Fix readme.

## 1.0.0

* Initial version.
