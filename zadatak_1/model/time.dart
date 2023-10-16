class Time {
  final int hour;
  final int minute;
  final int second;
  Time({required this.hour, required this.minute, required this.second});
  Time copyWith({int? hour, int? minute, int? second}) {
    return Time(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second);
  }
}
