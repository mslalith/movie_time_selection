extension DateTimeX on DateTime {
  bool isDateEqualTo(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  bool isTimeEqualTo(DateTime other) {
    return this.hour == other.hour && this.minute == other.minute;
  }

  String get timeNotation {
    final h = hour < 10 ? '$hour'.padLeft(2, '0') : '$hour';
    final m = minute < 10 ? '$minute'.padLeft(2, '0') : '$minute';
    return '$h:$m';
  }
}
