import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';

import '__globals.dart';

Future<void> main() async {
  String? bold(dynamic value) => styleBold.wrap('$value');

  var count = 0;
  final buffer = StringBuffer();
  final scripts = join(Directory.current.path, 'scripts');
  final scriptsLink = bold(link(uri: Uri.file(scripts)));
  await for (final command in Directory(scripts)
      .list()
      .where((e) => e is File)
      .cast<File>()
      .map((file) => split(file.path).last)
      .where((path) => !path.startsWith('_'))
      .where((path) => path.endsWith('.dart'))
      .map((file) => file.split('.').first)) {
    buffer.writeln('${++count}. ${bold(command)}');
  }

  if (count <= 0) {
    return logger.err('Could not find any dart scripts in $scriptsLink.');
  }

  logger
    ..success(
      'Found ${bold('$count')} available dart scripts in $scriptsLink.',
    )
    ..write('$buffer');
}
