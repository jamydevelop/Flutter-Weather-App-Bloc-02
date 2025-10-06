import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app_bloc_02/bloc/weather_bloc.dart';
import 'package:flutter_weather_app_bloc_02/models/weather_model.dart';
import 'package:flutter_weather_app_bloc_02/views/widgets/weather_icon_widget.dart';

class SuccessStateWidget extends StatelessWidget {
  final WeatherModel weather;
  final Color textColor;
  final TextEditingController controller;
  final String formattedTime; // New parameter

  const SuccessStateWidget({
    super.key,
    required this.weather,
    required this.textColor,
    required this.controller,
    required this.formattedTime, // New parameter
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City Name Row
            Row(
              children: [
                Image.asset('assets/pin16.png'),
                const SizedBox(width: 8),
                Text(
                  weather.city,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Weather Icon
            Center(child: WeatherIconWidget(code: weather.weatherCodes)),

            const SizedBox(height: 20),

            // Temperature
            Center(
              child: Text(
                '${weather.temperature}°C',
                style: TextStyle(
                  color: textColor,
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Weather Condition
            Center(
              child: Text(
                weather.weatherCondition,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Date and Time
            Center(
              child: Text(
                formattedTime, // Use passed formattedTime here
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Humidity & Wind Speed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Humidity
                Row(
                  children: [
                    Image.asset('assets/humidity512.png', scale: 10),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Humidity',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${weather.humidity} %',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Wind Speed
                Row(
                  children: [
                    Image.asset('assets/windspeed512.png', scale: 12),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wind Speed',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${weather.windSpeed} %',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Text Field
            TextField(
              controller: controller,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Enter city name',
                labelStyle: TextStyle(color: textColor),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // SEARCH BUTTON
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColor == Colors.white
                      ? Colors.grey[800]
                      : null,
                ),
                onPressed: () {
                  final city = controller.text.trim();
                  if (city.isNotEmpty) {
                    context.read<WeatherBloc>().add(GetWeatherEvent(city));
                  }
                  controller.clear();
                },
                child: Text('Search', style: TextStyle(color: textColor)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
