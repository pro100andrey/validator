import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

void main() {
  final ref = DateTime(2020);

  group('AfterValidator', () {
    final v = AfterValidator(dateTime: ref, error: 'error');

    test('later passes', () => expect(v(DateTime(2020, 1, 2)), isNull));
    test('earlier fails', () => expect(v(DateTime(2019, 12, 31)), 'error'));
    test('null is skipped', () => expect(v(null), isNull));
  });

  group('BeforeValidator', () {
    final v = BeforeValidator(dateTime: ref, error: 'error');

    test('earlier passes', () => expect(v(DateTime(2019)), isNull));
    test('later fails', () => expect(v(DateTime(2021)), 'error'));
  });

  group('DateBetweenValidator', () {
    final v = DateBetweenValidator(
      start: DateTime(2020),
      end: DateTime(2020, 12, 31),
      error: 'error',
    );

    test('inside passes', () => expect(v(DateTime(2020, 6)), isNull));
    test('boundaries pass', () {
      expect(v(DateTime(2020)), isNull);
      expect(v(DateTime(2020, 12, 31)), isNull);
    });
    test('outside fails', () => expect(v(DateTime(2021)), 'error'));
  });

  group('Past/Future with an injected clock', () {
    DateTime now() => DateTime(2020, 6, 15);

    test('PastValidator', () {
      final v = PastValidator(error: 'error', clock: now);
      expect(v(DateTime(2020, 6, 14)), isNull);
      expect(v(DateTime(2020, 6, 16)), 'error');
    });

    test('FutureValidator', () {
      final v = FutureValidator(error: 'error', clock: now);
      expect(v(DateTime(2020, 6, 16)), isNull);
      expect(v(DateTime(2020, 6, 14)), 'error');
    });
  });

  group('composition with &', () {
    final v = AfterValidator(dateTime: DateTime(2000), error: 'after') &
        BeforeValidator(dateTime: DateTime(2030), error: 'before');

    test('within range passes', () => expect(v(DateTime(2020)), isNull));
    test('too early reports first', () => expect(v(DateTime(1990)), 'after'));
    test('too late reports second', () => expect(v(DateTime(2040)), 'before'));
  });
}
