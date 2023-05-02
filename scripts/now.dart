import 'package:mason_logger/mason_logger.dart';
import 'package:recase/recase.dart';

import '__globals.dart';

void main() {
  final now = DateTime.now();

  final weekday = Day.values[now.weekday];
  final month = Month.values[now.month - 1];
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
  january('January'),
  february('February'),
  march('March'),
  april('April'),
  may('May'),
  june('June'),
  july('July'),
  august('August'),
  september('September'),
  october('October'),
  november('November'),
  december('December');

  const Month(this.label);

  final String label;

  @override
  String toString() => label;
}
