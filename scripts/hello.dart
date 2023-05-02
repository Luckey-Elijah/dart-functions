import '__globals.dart';

void main(List<String> args) {
  logger
    ..alert('Hi, mom!')
    ..detail('length: ${args.length}')
    ..err('args: $args');
}
