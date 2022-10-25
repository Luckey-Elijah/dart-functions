import 'dart:io';

void main() {
  final now = DateTime.now();

  final weekday = dayOfTheWeekFromInt(now.weekday);
  final month = monthFromInt(now.month);
  final day = now.day;

  final isPm = now.hour > 11;
  final hour = isPm ? now.hour - 12 : now.hour;

  final time = '${hour}:${now.minute} ${isPm ? 'p' : 'a'}.m.';

  stdout.writeln(
    'Today is $weekday, $month $day — $time',
  );
}

String dayOfTheWeekFromInt(int day) => const {
      DateTime.monday: 'Monday',
      DateTime.tuesday: 'Tuesday',
      DateTime.wednesday: 'Wednesday',
      DateTime.thursday: 'Thursday',
      DateTime.friday: 'Friday',
      DateTime.saturday: 'Saturday',
      DateTime.sunday: 'Sunday',
    }[day]!;

String monthFromInt(int month) => const {
      DateTime.january: 'January',
      DateTime.february: 'February',
      DateTime.march: 'March',
      DateTime.april: 'April',
      DateTime.may: 'May',
      DateTime.june: 'June',
      DateTime.july: 'July',
      DateTime.august: 'August',
      DateTime.september: 'September',
      DateTime.october: 'October',
      DateTime.november: 'November',
      DateTime.december: 'December',
    }[month]!;
