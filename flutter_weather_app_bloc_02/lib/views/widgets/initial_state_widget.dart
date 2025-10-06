import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app_bloc_02/bloc/weather_bloc.dart';

class InitialStateWidget extends StatelessWidget {
  final TextEditingController controller;

  const InitialStateWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Center(
        child: Column(
          children: [
            const Text('Enter a city name to get started.'),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final city = controller.text.trim();
                if (city.isNotEmpty) {
                  context.read<WeatherBloc>().add(GetWeatherEvent(city));
                }
                controller.clear();
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
