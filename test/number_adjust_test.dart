import 'package:number_adjust/number_adjust.dart';
import 'package:test/test.dart';

void main() {
  group('numberAdjust', () {
    test('"1.0" up --> "1.1"', () {
      expect(numberAdjust('1.0', direction: .up), '1.1');
    });

    test('"1.0" down --> "0.9"', () {
      expect(numberAdjust('1.0', direction: .down), '0.9');
    });

    test('"4" up --> "5"', () {
      expect(numberAdjust('4', direction: .up), '5');
    });

    test('"4" down --> "3"', () {
      expect(numberAdjust('4', direction: .down), '3');
    });

    test('"1.00" up --> "1.01"', () {
      expect(numberAdjust('1.00', direction: .up), '1.01');
    });

    test('"1.00" down --> "0.99"', () {
      expect(numberAdjust('1.00', direction: .down), '0.99');
    });

    test('"0" down --> "-1"', () {
      expect(numberAdjust('0', direction: .down), '-1');
    });

    test('"0.0" down --> "-0.1"', () {
      expect(numberAdjust('0.0', direction: .down), '-0.1');
    });

    test('"10" up -> "11"', () {
      expect(numberAdjust('10', direction: .up), '11');
    });

    test('"10" down -> "9"', () {
      expect(numberAdjust('10', direction: .down), '9');
    });

    test('"100" up -> "110"', () {
      expect(numberAdjust('100', direction: .up), '110');
    });

    test('"100" down -> "90"', () {
      expect(numberAdjust('100', direction: .down), '90');
    });

    test('"3000" up -> "3100"', () {
      expect(numberAdjust('3000', direction: .up), '3100');
    });

    test('"3000" down -> "2900"', () {
      expect(numberAdjust('3000', direction: .down), '2900');
    });

    test('"-100" up -> "-90"', () {
      expect(numberAdjust('-100', direction: .up), '-90');
    });

    test('"-100" down -> "-110"', () {
      expect(numberAdjust('-100', direction: .down), '-110');
    });
  });
}
