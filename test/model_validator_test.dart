import 'package:pro_validator/pro_validator.dart';
import 'package:test/test.dart';

class _User {
  _User({
    required this.email,
    required this.age,
    required this.password,
    required this.confirm,
    this.id = '',
    this.wantsDiscount = false,
    this.code = '',
  });

  final String email;
  final num age;
  final String password;
  final String confirm;
  final String id;
  final bool wantsDiscount;
  final String code;
}

class _UserValidator extends ModelValidator<_User> {
  _UserValidator() {
    ruleFor('email')
        .check((u) => u.email, const RequiredValidator(error: 'required'))
        .check((u) => u.email, const EmailValidator(error: 'bad email'));

    ruleFor(
      'age',
    ).check((u) => u.age, const MinValidator(min: 18, error: '18+'));

    ruleFor('confirm').must((u) => u.confirm == u.password, error: 'mismatch');

    ruleFor('code')
        .check((u) => u.code, const RequiredValidator(error: 'code required'))
        .when((u) => u.wantsDiscount);

    ruleFor('id')
        .check((u) => u.id, const RequiredValidator(error: 'id required'))
        .only('update');
  }
}

class _ChainedValidator extends ModelValidator<_User> {
  _ChainedValidator() {
    ruleFor('code')
        .check((u) => u.code, const RequiredValidator(error: 'code required'))
        .when((u) => u.wantsDiscount)
        .when((u) => u.age >= 18); // second guard → AND-combined with the first
  }
}

class _Opt {
  _Opt({this.nickname, this.count, this.optional = false});

  final String? nickname;
  final num? count;
  final bool optional;
}

class _OptValidator extends ModelValidator<_Opt> {
  _OptValidator() {
    ruleFor('nickname')
        .check((o) => o.nickname, const RequiredValidator(error: 'required'))
        .unless((o) => o.optional); // skip the check when optional

    ruleFor(
      'count',
    ).check((o) => o.count, const MinValidator(min: 1, error: 'min 1'));

    ruleFor('tag')
        .must((o) => o.nickname != 'bad', error: 'bad tag')
        .only('create')
        .only('update'); // shared across two rule-sets
  }
}

_User _valid() => _User(
  email: 'user@mail.com',
  age: 30,
  password: 'secret',
  confirm: 'secret',
  id: 'u1',
);

void main() {
  final validator = _UserValidator();

  test('a valid model has no errors', () {
    final r = validator.validate(_valid());
    expect(r.isValid, isTrue);
    expect(r.errors, isEmpty);
    expect(r.firstFor('email'), isNull);
    expect(r.errorsFor('email'), isEmpty);
  });

  test('field validators run and key the result', () {
    final r = validator.validate(
      _User(email: 'nope', age: 30, password: 'x', confirm: 'x'),
    );
    expect(r.isValid, isFalse);
    expect(r.errorsFor('email'), ['bad email']);
    expect(r.firstFor('email'), 'bad email');
  });

  test('typed value validator (num) is reused', () {
    final r = validator.validate(
      _User(email: 'user@mail.com', age: 10, password: 'x', confirm: 'x'),
    );
    expect(r.errorsFor('age'), ['18+']);
  });

  test('cross-field rule via must', () {
    final r = validator.validate(
      _User(email: 'user@mail.com', age: 30, password: 'a', confirm: 'b'),
    );
    expect(r.errorsFor('confirm'), ['mismatch']);
  });

  group('conditional rule (when)', () {
    test('skipped when condition is false', () {
      final r = validator.validate(_valid());
      expect(r.errorsFor('code'), isEmpty);
    });

    test('runs and fails when condition is true and field is empty', () {
      final r = validator.validate(
        _User(
          email: 'user@mail.com',
          age: 30,
          password: 'x',
          confirm: 'x',
          wantsDiscount: true,
        ),
      );
      expect(r.errorsFor('code'), ['code required']);
    });

    test('runs and passes when the conditional field is filled', () {
      final r = validator.validate(
        _User(
          email: 'user@mail.com',
          age: 30,
          password: 'x',
          confirm: 'x',
          wantsDiscount: true,
          code: 'SAVE10',
        ),
      );
      expect(r.errorsFor('code'), isEmpty);
    });
  });

  group('chained conditions combine with AND', () {
    final chained = _ChainedValidator();

    _User user({required bool wantsDiscount, required num age}) => _User(
      email: 'user@mail.com',
      age: age,
      password: 'x',
      confirm: 'x',
      wantsDiscount: wantsDiscount,
    );

    test('runs only when both conditions hold', () {
      expect(
        chained.validate(user(wantsDiscount: true, age: 20)).errorsFor('code'),
        ['code required'],
      );
    });

    test('skipped when the first condition is false', () {
      expect(
        chained.validate(user(wantsDiscount: false, age: 20)).errorsFor('code'),
        isEmpty,
      );
    });

    test('skipped when the second condition is false', () {
      expect(
        chained.validate(user(wantsDiscount: true, age: 15)).errorsFor('code'),
        isEmpty,
      );
    });
  });

  group('rule-sets (only)', () {
    final noId = _User(
      email: 'user@mail.com',
      age: 30,
      password: 'x',
      confirm: 'x',
    );

    test('tagged rule is skipped without a matching rule-set', () {
      expect(validator.validate(noId).errorsFor('id'), isEmpty);
      expect(
        validator.validate(noId, ruleSet: 'create').errorsFor('id'),
        isEmpty,
      );
    });

    test('tagged rule runs for its rule-set', () {
      final r = validator.validate(noId, ruleSet: 'update');
      expect(r.errorsFor('id'), ['id required']);
    });
  });

  group('unless / typed-null / multi rule-set', () {
    final opt = _OptValidator();

    test('unless skips the rule when the condition holds', () {
      expect(opt.validate(_Opt()).errorsFor('nickname'), ['required']);
      expect(
        opt.validate(_Opt(optional: true)).errorsFor('nickname'),
        isEmpty,
      );
    });

    test('check() skips a null typed field but still checks a present one', () {
      // count defaults to null → the typed MinValidator is skipped.
      expect(
        opt.validate(_Opt(nickname: 'ok')).errorsFor('count'),
        isEmpty,
      );
      expect(
        opt.validate(_Opt(nickname: 'ok', count: 0)).errorsFor('count'),
        ['min 1'],
      );
    });

    test('a rule tagged to two rule-sets runs in both', () {
      final bad = _Opt(nickname: 'bad');
      expect(
        opt.validate(bad, ruleSet: 'create').errorsFor('tag'),
        ['bad tag'],
      );
      expect(
        opt.validate(bad, ruleSet: 'update').errorsFor('tag'),
        ['bad tag'],
      );
      expect(opt.validate(bad).errorsFor('tag'), isEmpty); // no rule-set
    });

    test('validate() returns an unmodifiable result', () {
      final r = opt.validate(_Opt());
      expect(() => r.errorsFor('nickname').add('x'), throwsUnsupportedError);
    });
  });
}
