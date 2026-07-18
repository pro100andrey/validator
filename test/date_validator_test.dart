import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  final ref = DateTime(2020);

  group('AfterValidator', () {
    final v = AfterValidator(dateTime: ref, error: 'error');

    test('later passes', () => expect(v(DateTime(2020, 1, 2)), isNull));
    test('earlier fails', () => expect(v(DateTime(2019, 12, 31)), 'error'));
    test('equal fails (strictly after)', () => expect(v(ref), 'error'));
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('BeforeValidator', () {
    final v = BeforeValidator(dateTime: ref, error: 'error');

    test('earlier passes', () => expect(v(DateTime(2019)), isNull));
    test('later fails', () => expect(v(DateTime(2021)), 'error'));
    test('equal fails (strictly before)', () => expect(v(ref), 'error'));
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('DateRangeValidator', () {
    final v = DateRangeValidator(
      start: DateTime(2020),
      end: DateTime(2020, 12, 31),
      error: 'error',
    );

    test('inside passes', () => expect(v(DateTime(2020, 6)), isNull));
    test('start boundary passes', () => expect(v(DateTime(2020)), isNull));
    test(
      'end boundary passes',
      () => expect(v(DateTime(2020, 12, 31)), isNull),
    );
    test('before start fails', () => expect(v(DateTime(2019)), 'error'));
    test('after end fails', () => expect(v(DateTime(2021)), 'error'));
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('PastValidator', () {
    DateTime now() => DateTime(2020, 6, 15);
    final v = PastValidator(error: 'error', clock: now);

    test(
      'earlier than now passes',
      () => expect(v(DateTime(2020, 6, 14)), isNull),
    );
    test(
      'later than now fails',
      () => expect(v(DateTime(2020, 6, 16)), 'error'),
    );
    test('exactly now fails (strictly past)', () => expect(v(now()), 'error'));
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('FutureValidator', () {
    DateTime now() => DateTime(2020, 6, 15);
    final v = FutureValidator(error: 'error', clock: now);

    test(
      'later than now passes',
      () => expect(v(DateTime(2020, 6, 16)), isNull),
    );
    test(
      'earlier than now fails',
      () => expect(v(DateTime(2020, 6, 14)), 'error'),
    );
    test(
      'exactly now fails (strictly future)',
      () => expect(v(now()), 'error'),
    );
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('composition with &', () {
    final v =
        AfterValidator(dateTime: DateTime(2000), error: 'after') &
        BeforeValidator(dateTime: DateTime(2030), error: 'before');

    test('within range passes', () => expect(v(DateTime(2020)), isNull));
    test('too early reports first', () => expect(v(DateTime(1990)), 'after'));
    test('too late reports second', () => expect(v(DateTime(2040)), 'before'));
  });
}
