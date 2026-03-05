import 'package:number_adjust/number_adjust.dart';
import 'package:number_adjust/number_adjust_in_place.dart';
import 'package:test/test.dart';

void main() {
  group('numberAdjustInPlace', () {
    test('adjusts number in the middle of a string', () {
      final lines = ['The value is 123.45 volts'];
      final result = numberAdjustInPlace(
        lines,
        row: 0,
        column: 17, // Digit '4' in '123.45'
        direction: AdjustDirection.up,
      );
      expect(result[0], 'The value is 123.55 volts');
    });

    test('adjusts number when cursor is at the digit', () {
      final lines = ['Value: 100'];
      final result = numberAdjustInPlace(
        lines,
        row: 0,
        column: 7, // Digit '1' in '100'
        direction: AdjustDirection.up,
      );
      expect(result[0], 'Value: 200');
    });

    test('adjusts number when cursor is at the end', () {
      final lines = ['Count: 50'];
      final result = numberAdjustInPlace(
        lines,
        row: 0,
        column: 8, // Digit '0' in '50'
        direction: AdjustDirection.down,
      );
      expect(result[0], 'Count: 49');
    });

    test('handles negative numbers', () {
      final lines = ['Offset: -100'];
      final result = numberAdjustInPlace(
        lines,
        row: 0,
        column: 9, // Digit '1' in '-100' (idx 8 is '-', idx 9 is '1')
        direction: AdjustDirection.up,
      );
      expect(result[0], 'Offset: 0');
    });

    test('throws NoNumberFound when no number is at cursor', () {
      final lines = ['Hello world'];
      expect(
        () => numberAdjustInPlace(
          lines,
          row: 0,
          column: 5,
          direction: AdjustDirection.up,
        ),
        throwsA(isA<NoNumberFound>()),
      );
    });

    test('handles multiple rows', () {
      final lines = ['First line', 'Value: 10', 'Third line'];
      final result = numberAdjustInPlace(
        lines,
        row: 1,
        column: 8, // Digit '0' in 'Value: 10'
        direction: AdjustDirection.up,
      );
      expect(result.length, 3);
      expect(result[0], 'First line');
      expect(result[1], 'Value: 11');
      expect(result[2], 'Third line');
    });
  });
}
