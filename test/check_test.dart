import 'package:pro_validator/src/check.dart';
import 'package:test/test.dart';

void main() {
  group('Check', () {
    test('isWhitespace', () {
      expect(isWhitespace(''), isTrue);
      expect(isWhitespace(' '), isTrue);
      expect(isWhitespace('\t'), isTrue);
      expect(isWhitespace('\n'), isTrue);
      expect(isWhitespace('\r'), isTrue);
      expect(isWhitespace(' \t\n\r'), isTrue);

      expect(isWhitespace('a'), isFalse);
      expect(isWhitespace(' a'), isFalse);
      expect(isWhitespace('a '), isFalse);
    });

    test('isAlphabetic', () {
      expect(isAlphabetic('a'), isTrue);
      expect(isAlphabetic('A'), isTrue);
      expect(isAlphabetic('z'), isTrue);
      expect(isAlphabetic('Z'), isTrue);
      expect(isAlphabetic('aA'), isTrue);

      expect(isAlphabetic(''), isFalse);
      expect(isAlphabetic('a '), isFalse);
      expect(isAlphabetic(' a'), isFalse);
      expect(isAlphabetic('1'), isFalse);
      expect(isAlphabetic('!'), isFalse);
    });

    test('isAlphaNumeric', () {
      expect(isAlphaNumeric('a1'), isTrue);
      expect(isAlphaNumeric('123'), isTrue);
      expect(isAlphaNumeric('abc'), isTrue);

      expect(isAlphaNumeric(''), isFalse);
      expect(isAlphaNumeric('abc!'), isFalse);
      expect(isAlphaNumeric(' '), isFalse);
    });

    test('isSurrogatePairs', () {
      expect(isSurrogatePairs('😀'), isTrue);
      expect(isSurrogatePairs('a😀'), isTrue);
      expect(isSurrogatePairs('😊😉😍'), isTrue);
      expect(isSurrogatePairs('\uD83D\uDC00'), isTrue);

      expect(isSurrogatePairs('a'), isFalse);
      expect(isSurrogatePairs('abc'), isFalse);
      expect(isSurrogatePairs('123'), isFalse);
      expect(isSurrogatePairs('!@#'), isFalse);
      expect(isSurrogatePairs(''), isFalse);
      expect(isSurrogatePairs('\n'), isFalse);
      expect(isSurrogatePairs('\uD83D'), isFalse);
      expect(isSurrogatePairs('\uDC00'), isFalse);
    });

    test('anyNonAscii', () {
      expect(isAnyNonAscii('😀'), isTrue);
      expect(isAnyNonAscii('a😀'), isTrue);
      expect(isAnyNonAscii('😊😉😍'), isTrue);
      expect(isAnyNonAscii('😀a'), isTrue);
      expect(isAnyNonAscii('a😀b'), isTrue);
      expect(isAnyNonAscii('😀😊😉😍'), isTrue);
      expect(isAnyNonAscii('a😀😊😉😍b'), isTrue);

      expect(isAnyNonAscii('a'), isFalse);
      expect(isAnyNonAscii('abc'), isFalse);
      expect(isAnyNonAscii('123'), isFalse);
      expect(isAnyNonAscii('!@#'), isFalse);
      expect(isAnyNonAscii(''), isFalse);
      expect(isAnyNonAscii('\n'), isFalse);
    });

    test('isOnlyAscii', () {
      expect(isOnlyAscii('a'), isTrue);
      expect(isOnlyAscii('abc'), isTrue);
      expect(isOnlyAscii('123'), isTrue);
      expect(isOnlyAscii('!@#'), isTrue);
      expect(isOnlyAscii(' '), isTrue);
      expect(isOnlyAscii('\n'), isTrue);

      expect(isOnlyAscii(''), isFalse);
      expect(isOnlyAscii('😀'), isFalse);
      expect(isOnlyAscii('a😀'), isFalse);
      expect(isOnlyAscii('😊😉😍'), isFalse);
      expect(isOnlyAscii('😀a'), isFalse);
      expect(isOnlyAscii('a😀b'), isFalse);
      expect(isOnlyAscii('😀😊😉😍'), isFalse);
      expect(isOnlyAscii('a😀😊😉😍b'), isFalse);
    });

    test('isInteger', () {
      expect(isInteger('0'), isTrue);
      expect(isInteger('1'), isTrue);
      expect(isInteger('123'), isTrue);
      expect(isInteger('-1'), isTrue);
      expect(isInteger('-123'), isTrue);

      expect(isInteger(''), isFalse);
      expect(isInteger('a'), isFalse);
      expect(isInteger('1.0'), isFalse);
      expect(isInteger('1.1'), isFalse);
      expect(isInteger('1.1e10'), isFalse);
    });

    test('isDecimal', () {
      expect(isDecimal('0'), isTrue);
      expect(isDecimal('1'), isTrue);
      expect(isDecimal('123'), isTrue);
      expect(isDecimal('-1'), isTrue);
      expect(isDecimal('-123'), isTrue);
      expect(isDecimal('1.0'), isTrue);
      expect(isDecimal('1.1'), isTrue);
      expect(isDecimal('1.1e10'), isTrue);

      expect(isDecimal(''), isFalse);
      expect(isDecimal('a'), isFalse);
      expect(isDecimal('1.1e'), isFalse);
      expect(isDecimal('1.1e+'), isFalse);
    });

    test('isNumeric', () {
      expect(isNumeric('0'), isTrue);
      expect(isNumeric('000'), isTrue);
      expect(isNumeric('1'), isTrue);
      expect(isNumeric('123'), isTrue);
      expect(isNumeric('-1'), isTrue);
      expect(isNumeric('-123'), isTrue);

      expect(isNumeric('1.1e10'), isFalse);
      expect(isNumeric('1.0'), isFalse);
      expect(isNumeric(''), isFalse);
      expect(isNumeric('a'), isFalse);
      expect(isNumeric('1.1e'), isFalse);
      expect(isNumeric('1.1e+'), isFalse);
    });

    test('isHexadecimal', () {
      expect(isHexadecimal('0'), isTrue);
      expect(isHexadecimal('1'), isTrue);
      expect(isHexadecimal('123'), isTrue);
      expect(isHexadecimal('a'), isTrue);
      expect(isHexadecimal('A'), isTrue);
      expect(isHexadecimal('f'), isTrue);
      expect(isHexadecimal('F'), isTrue);
      expect(isHexadecimal('abcdef'), isTrue);
      expect(isHexadecimal('ABCDEF'), isTrue);

      expect(isHexadecimal('g'), isFalse);
      expect(isHexadecimal('G'), isFalse);
      expect(isHexadecimal('123g'), isFalse);
      expect(isHexadecimal('123G'), isFalse);
      expect(isHexadecimal(''), isFalse);
      expect(isHexadecimal('1.0'), isFalse);
      expect(isHexadecimal('1.1e10'), isFalse);
    });

    test('isHexColor', () {
      expect(isHexColor('#FFF'), isTrue);
      expect(isHexColor('FFF'), isTrue);
      expect(isHexColor('#FFFFFF'), isTrue);
      expect(isHexColor('FFFFFF'), isTrue);

      expect(isHexColor('#GGG'), isFalse);
      expect(isHexColor('#FFFFF'), isFalse);
      expect(isHexColor(''), isFalse);
      expect(isHexColor('1234567'), isFalse);
    });
  });
}
