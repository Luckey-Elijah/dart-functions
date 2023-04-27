import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) throw Exception('You must specify arguments');
  Process.run('touch', args);
}
