import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'ea1ddbc399a51b3b1b17bb8c56dcc6ea';
  final String baseURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        '$baseURL?q=$city&appid=ea1ddbc399a51b3b1b17bb8c56dcc6ea&units=imperial',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
