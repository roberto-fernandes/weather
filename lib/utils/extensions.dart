extension StringExtension on String {
  String get capitalized {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeFormatted on DateTime {
  String get weekdayName {
    switch(weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
    }
    return '';
  }
  String get shortWeekdayName {
    return weekdayName.substring(0, 3);
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }
}