class WeatherModel {
  final String city;
  final String weatherCondition;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final int timestamp;
  final int weatherCodes;
  final int timezoneOffset;

  WeatherModel({
    required this.city,
    required this.weatherCondition,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.timestamp,
    required this.weatherCodes,
    required this.timezoneOffset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
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
}
