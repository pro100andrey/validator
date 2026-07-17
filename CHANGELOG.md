## 3.0.0

Major refactor. The library is now split into focused modules and ships a new
low-level string-checking layer.

### Breaking changes

* `MatchValidator` now compares values with `==` instead of `identical`, so two
  equal runtime strings (e.g. two form fields) correctly match. Its signature is
  `call(Object?, Object?)`.
* `RequiredValidator` now correctly fails on empty and `null` input (previously
  it was short-circuited and returned `null`).
* Empty/`null` handling is centralised: every validator except
  `RequiredValidator` treats empty/`null` as valid and skips its check. Pass
  `ignoreEmptyValues: false` to opt back in.
* `MultiValidator.call` now returns the failing validator's actual result rather
  than re-reading its `error`.

### Added

* `CreditCardValidator` — scheme regex **plus** Luhn checksum.
* `OneOfValidator`, `FileExtensionValidator`, `ConditionalValidator`.
* `MultiValidator.errors()` to collect every failing message at once.
* `&` operator to compose validators without building a list manually.
* A `PatternValidator` (concrete) alongside the abstract `PatternTextValidator`.
* Public `Patterns` enum, `isX(String)` checkers and `String` extensions
  (`'x'.isEmail`, `isLuhnValid(...)`, etc.), now exported from the package.

### Fixed

* Corrected swapped latitude/longitude doc comments and email pattern docs.

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
