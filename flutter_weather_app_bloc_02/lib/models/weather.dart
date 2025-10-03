// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String city;
  final String weatherCondition;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final int timestamp;
  final int weatherCodes;
  Weather({
    required this.city,
    required this.weatherCondition,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
    required this.weatherCodes,
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
    );
  }
}

// class Weather {
//   final String city;
//   final String description;
//   final String temperature;
//   Weather({
//     required this.city,
//     required this.description,
//     required this.temperature,
//   });
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       city: json['name'],
//       description: json['weather'][0]['description'],
//       temperature: json['main']['temp'].toString(),
//     );
//   }
// }
