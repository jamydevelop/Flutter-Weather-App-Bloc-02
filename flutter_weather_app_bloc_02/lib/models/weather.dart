import 'package:intl/intl.dart';

class Weather {
  final String city;
  final String weatherCondition;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final int timestamp;
  final int weatherCodes;
  final int timezoneOffset;

  Weather({
    required this.city,
    required this.weatherCondition,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
    required this.weatherCodes,
    required this.timezoneOffset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      weatherCondition: json['weather'][0]['main'],
      temperature: (json['main']['temp'] as num).round().toString(),
      humidity: json['main']['humidity'].toString(),
      windSpeed: json['wind']['speed'].toString(),
      timestamp: json['dt'],
      weatherCodes: json['weather'][0]['id'],
      timezoneOffset: json['timezone'],
    );
  }

  String get formattedTime {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat.jm().format(localDateTime);
  }

  // New getter for hour and minutes only (e.g. "4:43")
  String get formattedHourMinute {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat('h:mm').format(localDateTime);
  }

  // New getter for AM or PM only
  String get amPm {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat('a').format(localDateTime);
  }
}
