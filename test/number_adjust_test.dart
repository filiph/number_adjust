import 'package:number_adjust/number_adjust.dart';
import 'package:test/test.dart';

void main() {
  group('numberAdjust', () {
    test('"109" pos 2 (9) up --> "110"', () {
      expect(
        numberAdjust('109', position: 2, direction: AdjustDirection.up),
        '110',
      );
    });

    test('"109" pos 2 (9) down --> "108"', () {
      expect(
        numberAdjust('109', position: 2, direction: AdjustDirection.down),
        '108',
      );
    });

    test('"100.9" pos 4 (9) up --> "101.0"', () {
      expect(
        numberAdjust('100.9', position: 4, direction: AdjustDirection.up),
        '101.0',
      );
    });

    test('"100.9" pos 4 (9) down --> "100.8"', () {
      expect(
        numberAdjust('100.9', position: 4, direction: AdjustDirection.down),
        '100.8',
      );
    });

    test('"0" pos 0 (0) up --> "1"', () {
      expect(
        numberAdjust('0', position: 0, direction: AdjustDirection.up),
        '1',
      );
    });

    test('"0" pos 0 (0) down --> "-1"', () {
      expect(
        numberAdjust('0', position: 0, direction: AdjustDirection.down),
        '-1',
      );
    });

    test('"0.1" pos 0 (0) up --> "1.1"', () {
      expect(
        numberAdjust('0.1', position: 0, direction: AdjustDirection.up),
        '1.1',
      );
    });

    test('"0.1" pos 0 (0) down --> "-0.9"', () {
      expect(
        numberAdjust('0.1', position: 0, direction: AdjustDirection.down),
        '-0.9',
      );
    });

    test('"10" pos 1 (0) up --> "11"', () {
      expect(
        numberAdjust('10', position: 1, direction: AdjustDirection.up),
        '11',
      );
    });

    test('"10" pos 1 (0) down --> "9"', () {
      expect(
        numberAdjust('10', position: 1, direction: AdjustDirection.down),
        '9',
      );
    });

    test('"11.90" pos 4 (0) up --> "11.91"', () {
      expect(
        numberAdjust('11.90', position: 4, direction: AdjustDirection.up),
        '11.91',
      );
    });

    test('"11.90" pos 4 (0) down --> "11.89"', () {
      expect(
        numberAdjust('11.90', position: 4, direction: AdjustDirection.down),
        '11.89',
      );
    });

    test('"999" pos 1 (middle 9) up -> "1009"', () {
      expect(
        numberAdjust('999', position: 1, direction: AdjustDirection.up),
        '1009',
      );
    });

    test('"999" pos 1 (middle 9) down -> "989"', () {
      expect(
        numberAdjust('999', position: 1, direction: AdjustDirection.down),
        '989',
      );
    });

    test('"0.999" pos 3 (middle 9) up -> "1.009"', () {
      expect(
        numberAdjust('0.999', position: 3, direction: AdjustDirection.up),
        '1.009',
      );
    });

    test('"0.999" pos 3 (middle 9) down -> "0.989"', () {
      expect(
        numberAdjust('0.999', position: 3, direction: AdjustDirection.down),
        '0.989',
      );
    });
  });
}
