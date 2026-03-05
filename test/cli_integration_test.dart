import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('CLI Integration', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('number_adjust_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    Future<ProcessResult> runCli(List<String> args) {
      final projectRoot = '.';
      return Process.run('dart', [
        p.join(projectRoot, 'bin', 'number_adjust.dart'),
        ...args,
      ]);
    }

    test('successfully adjusts a number in-place', () async {
      final inputFile = File(p.join(tempDir.path, 'input.txt'));
      inputFile.writeAsStringSync('100\n');

      final result = await runCli([
        '--input',
        inputFile.path,
        '--row',
        '1',
        '--col',
        '1', // Digit '1' in '100'
        '--direction',
        'up',
      ]);

      expect(result.exitCode, 0, reason: result.stderr.toString());
      expect(inputFile.readAsStringSync(), '200\n');
    });

    test('successfully adjusts a number to a different output file', () async {
      final inputFile = File(p.join(tempDir.path, 'input.txt'));
      final outputFile = File(p.join(tempDir.path, 'output.txt'));
      inputFile.writeAsStringSync('100\n');

      final result = await runCli([
        '--input',
        inputFile.path,
        '--output',
        outputFile.path,
        '--row',
        '1',
        '--col',
        '3', // Digit '0' (last) in '100'
        '--direction',
        'up',
      ]);

      expect(result.exitCode, 0, reason: result.stderr.toString());
      expect(inputFile.readAsStringSync(), '100\n');
      expect(outputFile.readAsStringSync(), '101\n');
    });

    test('fails with error message when no number is found', () async {
      final inputFile = File(p.join(tempDir.path, 'input.txt'));
      inputFile.writeAsStringSync('No numbers here\n');

      final result = await runCli([
        '--input',
        inputFile.path,
        '--row',
        '1',
        '--col',
        '6',
        '--direction',
        'up',
      ]);

      expect(result.exitCode, 1);
      expect(result.stderr, contains('Error: No number found at 1:6.'));
    });

    test('fails with error message when file does not exist', () async {
      final result = await runCli([
        '--input',
        p.join(tempDir.path, 'non_existent.txt'),
        '--row',
        '1',
        '--col',
        '1',
        '--direction',
        'up',
      ]);

      expect(result.exitCode, 1);
      expect(result.stderr, contains('Error: Input file'));
    });
  });
}
