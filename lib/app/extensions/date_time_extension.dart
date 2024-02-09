part of extensions;

extension DateTimeExtension on DateTime {
  // String get hhMMFormat {
  //   return DateFormat.Hm(AppConstants.locale).format(this);
  // }
  //
  // String get dMMMyyyyHHmm {
  //   return '${DateFormat.yMMMd(AppConstants.locale).format(this)} '
  //       '${DateFormat.Hm(AppConstants.locale).format(this)}';
  // }

  bool isSameHourAndMinute(DateTime other) {
    return (hour == other.hour) && (minute == other.minute);
  }

  bool isSameDay(DateTime otherDate) {
    return otherDate.year == year && otherDate.month == month && otherDate.day == day;
  }
}
