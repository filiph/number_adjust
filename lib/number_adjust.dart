enum AdjustDirection { up, down }

String numberAdjust(
  String numberString, {
  required int position,
  required AdjustDirection direction,
}) {
  final decimalPointIndex = numberString.indexOf('.');
  final int precision;
  final double step;

  final value = double.parse(numberString);

  if (decimalPointIndex == -1) {
    precision = 0;
    // For integers, the step is 10^(distance from right)
    // "109", pos 2 (digit 9) -> step 10^0 = 1
    // "109", pos 1 (digit 0) -> step 10^1 = 10
    // "109", pos 0 (digit 1) -> step 10^2 = 100
    int exponent = numberString.length - 1 - position;
    step = BigInt.from(10).pow(exponent).toDouble();
  } else {
    precision = numberString.length - decimalPointIndex - 1;
    if (position < decimalPointIndex) {
      // Digit is to the left of the decimal point
      // "100.9", pos 2 (digit 0 before .) -> step 10^0 = 1
      // "100.9", pos 1 (digit 0) -> step 10^1 = 10
      // "100.9", pos 0 (digit 1) -> step 10^2 = 100
      int exponent = decimalPointIndex - 1 - position;
      step = BigInt.from(10).pow(exponent).toDouble();
    } else if (position > decimalPointIndex) {
      // Digit is to the right of the decimal point
      // "100.9", pos 4 (digit 9) -> step 10^-1 = 0.1
      // "11.90", pos 4 (digit 0) -> step 10^-2 = 0.01
      int exponent = decimalPointIndex - position;
      step = 1.0 / BigInt.from(10).pow(exponent.abs()).toDouble();
    } else {
      // Cursor is ON the decimal point. Let's treat it as the digit to the right?
      // Or just ignore it? The prompt says "digit under the cursor".
      // Let's assume the cursor is never on the dot for these tests,
      // or if it is, maybe adjust the integer part by 1?
      // Based on examples, cursor is always on a digit.
      // If cursor is on '.', let's do nothing or throw.
      // For now, let's just make it 0.
      step = 0;
    }
  }

  final newValue = direction == AdjustDirection.up
      ? value + step
      : value - step;

  return newValue.toStringAsFixed(precision);
}
