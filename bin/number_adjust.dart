import 'dart:io';

import 'package:args/args.dart';
import 'package:number_adjust/number_adjust.dart';
import 'package:number_adjust/number_adjust_in_place.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'input',
      abbr: 'i',
      help: 'Path to the input file',
      mandatory: true,
    )
    ..addOption('row', abbr: 'r', help: '0-indexed row', mandatory: true)
    ..addOption('col', abbr: 'c', help: '0-indexed column', mandatory: true)
    ..addOption(
      'direction',
      abbr: 'd',
      help: 'Direction to adjust: up or down',
      mandatory: true,
      allowed: ['up', 'down'],
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Path to the output file (defaults to input file)',
    );

  try {
    final results = parser.parse(arguments);

    final inputPath = results['input'] as String;
    final row = int.parse(results['row'] as String);
    final col = int.parse(results['col'] as String);
    final directionStr = results['direction'] as String;
    final outputPath = (results['output'] as String?) ?? inputPath;

    final direction = directionStr == 'up'
        ? AdjustDirection.up
        : AdjustDirection.down;

    final inputFile = File(inputPath);
    if (!inputFile.existsSync()) {
      stderr.writeln('Error: Input file "$inputPath" does not exist.');
      exit(1);
    }

    final lines = await inputFile.readAsLines();

    try {
      final newLines = numberAdjustInPlace(
        lines,
        // row:col supplied from the command line is 1-based
        // (while we normally use 0-based).
        row: row - 1,
        column: col - 1,
        direction: direction,
      );

      await File(outputPath).writeAsString('${newLines.join('\n')}\n');
    } on NoNumberFound {
      stderr.writeln('Error: No number found at $row:$col.');
      exit(1);
    } catch (e) {
      stderr.writeln('Error during number adjustment: $e');
      exit(1);
    }
  } on FormatException catch (e) {
    stderr.writeln('Error parsing arguments: ${e.message}');
    stderr.writeln('\nUsage:\n${parser.usage}');
    exit(1);
  } catch (e) {
    stderr.writeln('Unexpected error: $e');
    exit(1);
  }
}
