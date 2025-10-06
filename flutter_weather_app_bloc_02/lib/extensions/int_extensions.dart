import 'package:intl/intl.dart';

extension TimestampFormatting on int {
  String formattedTime(int timezoneOffset) {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      this * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat.jm().format(localDateTime);
  }

  String formattedHourMinute(int timezoneOffset) {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      this * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat('h:mm').format(localDateTime);
  }

  String amPm(int timezoneOffset) {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      this * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat('a').format(localDateTime);
  }
}
