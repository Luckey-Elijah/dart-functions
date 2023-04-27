import 'package:mason_logger/mason_logger.dart';

final logger = Logger(level: Level.verbose);
void main(List<String> args) {
  logger
    ..alert('Hi, mom!')
    ..detail('length: ${args.length}')
    ..err('args: $args');
}
