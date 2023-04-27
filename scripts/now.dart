
import 'package:mason_logger/mason_logger.dart';
import 'package:recase/recase.dart';

final logger = Logger(level: Level.verbose);

void main() {
  final now = DateTime.now();

  final weekday = Day.values[now.weekday];
  final month = Month.values[now.month];
  final day = now.day;

  final isPm = now.hour > 11;
  final hour = isPm ? now.hour - 12 : now.hour;

  final time = '$hour:${now.minute} ${isPm ? 'p' : 'a'}.m.';


  final message = '$weekday, $month $day - $time';
  
  logger.detail('Today is ${green.wrap(message)}');
}

enum Day {
  monday('Monday', 0),
  tuesday('Tuesday', 1),
  wednesday('Wednesday', 2),
  thursday('Thursday', 3),
  friday('Friday', 4),
  saturday('Saturday', 5),
  sunday('Sunday', 6);

  const Day(this.label, this.order);
  final String label;
  final int order;

  @override
  String toString() => label.titleCase;
}

enum Month {
  january('January', 0),
  february('February', 1),
  march('March', 2),
  april('April', 3),
  may('May', 4),
  june('June', 5),
  july('July', 6),
  august('August', 7),
  september('September', 8),
  october('October', 9),
  november('November', 10),
  december('December', 11);

  const Month(this.label, this.order);
  final String label;
  final int order;

  @override
  String toString() => label;
}
