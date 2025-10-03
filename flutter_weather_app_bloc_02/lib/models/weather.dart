// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      temperature: json['main']['temp'].toString(),
      humidity: json['main']['humidity'].toString(),
      windSpeed: json['wind']['speed'].toString(),
      timestamp: json['dt'],
      weatherCodes: json['weather'][0]['id'],
      timezoneOffset: json['timezone'],
    );
  }

  // Format timestamp as local city time string using timezone offset
  String get formattedTime {
    final utcDateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    final localDateTime = utcDateTime.add(Duration(seconds: timezoneOffset));
    return DateFormat.jm().format(localDateTime);
  }
}
