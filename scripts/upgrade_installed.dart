import 'dart:convert';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

void main(List<String> args) async {
  final results = await 'dart pub global list'.asProcessRun;
  final output = results.stdout;
  if (output is! String) exit(1);

  var upgraded = 0;
  var notChanged = 0;

  final logger = Logger(level: Level.verbose);

  final lines = const LineSplitter()
      .convert(output)
      .map((e) => e.trim())
      .where((line) => line.isNotEmpty);

  final width = lines
      .map((e) => e.split(' ').first)
      .fold(0, (p, c) => p > c.length ? p : c.length);

  for (final line in lines) {
    final cli = line.split(' ');
    final name = cli.first;
    if (cli.length != 2) {
      logger.info('not upgrading $name: $line');
      continue; // not from pub.dev
    }
    final oldVersion = cli[1];

    final deactivateCmd = 'dart pub global deactivate $name';
    final label = name.padRight(width + 1);
    final progress = logger.progress('$label$oldVersion');
    final deactivate = await deactivateCmd.asProcessRun;

    if (deactivate.exitCode != 0) {
      progress.fail('Could not deactivte $name');
      continue; // didn't work, next
    }

    final activateCmd = 'dart pub global activate $name';
    final activate = await activateCmd.asProcessRun;

    if (activate.exitCode != 0) {
      logger.err(
        'Had issue with upgrading $name\n previous version was $oldVersion',
      );
    }

    if (activate.stdout is! String) {
      logger.err('Unexpected result from upgrading $name');
    }

    // "Activated melos 3.0.1."
    final newVersion = const LineSplitter()
        .convert(activate.stdout as String)
        .last
        .split(' ')
        .last;

    newVersion.contains(oldVersion) ? notChanged++ : upgraded++;
    progress.complete('$label$oldVersion -> $newVersion');
  }
  logger
    ..info('Upgraded $upgraded Dart CLIs')
    ..info('$notChanged CLIs had no update');
}

extension on String {
  Future<ProcessResult> get asProcessRun {
    final cmd = split(' ');
    return Process.run(cmd.first, cmd.sublist(1, cmd.length));
  }
}
