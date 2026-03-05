import 'number_adjust.dart';

class NoNumberFound implements Exception {
  @override
  String toString() =>
      'NoNumberFound: No number was found at the cursor location.';
}

/// Finds a number at the location of the cursor ([row]:[column]),
/// and uses [numberAdjust] to adjust it, then returns the whole modified file back.
/// If there is no number at the location, it throws [NoNumberFound] exception.
List<String> numberAdjustInPlace(
  List<String> lines, {
  required int row,
  required int column,
  required AdjustDirection direction,
}) {
  if (row < 0 || row >= lines.length) {
    throw NoNumberFound();
  }

  final line = lines[row];
  final regex = RegExp(r'-?\d+(\.\d+)?');
  final matches = regex.allMatches(line);

  for (final match in matches) {
    if (column >= match.start && column <= match.end) {
      final numberString = line.substring(match.start, match.end);
      final adjustedNumber = numberAdjust(numberString, direction: direction);

      final newLine = line.replaceRange(match.start, match.end, adjustedNumber);
      final newLines = List<String>.from(lines);
      newLines[row] = newLine;
      return newLines;
    }
  }

  throw NoNumberFound();
}
