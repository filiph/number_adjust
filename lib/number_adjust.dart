enum AdjustDirection { up, down }

String numberAdjust(String numberString, {required AdjustDirection direction}) {
  final decimalPointIndex = numberString.indexOf('.');
  final int precision;
  final double step;

  final value = double.parse(numberString);

  if (decimalPointIndex == -1) {
    precision = 0;
    final absValue = value.abs().toInt();
    if (absValue >= 10) {
      var digits = absValue.toString().length;
      step = BigInt.from(10).pow(digits - 2).toDouble();
    } else {
      step = 1.0;
    }
  } else {
    precision = numberString.length - decimalPointIndex - 1;
    step = 1.0 / (BigInt.from(10).pow(precision).toDouble());
  }

  final newValue = direction == AdjustDirection.up
      ? value + step
      : value - step;

  return newValue.toStringAsFixed(precision);
}
