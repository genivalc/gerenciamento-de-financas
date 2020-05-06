class DateUtils {
  static DateTime get firstDayOfMonth =>
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  static DateTime get firstDayOfNextMonth =>
      DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

  static DateTime get todayStart =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  static bool isToday(DateTime date) {
    if (date == null) return false;
    var now = DateTime.now();
    var startOfDay = DateTime(now.year, now.month, now.day);
    var startOfNextDay = startOfDay.add(Duration(days: 1));
    return date.isAfter(startOfDay) && date.isBefore(startOfNextDay);
  }

  static bool isOnCurrentMonth(DateTime date) {
    if (date == null) return false;
    return date.isAfter(firstDayOfMonth) && date.isBefore(firstDayOfNextMonth);
  }
}
