import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app_bloc_02/bloc/weather_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TEXT FIELD to enter city name
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // SEARCH BUTTON
            ElevatedButton(
              onPressed: () {
                final city = _controller.text.trim();
                if (city.isNotEmpty) {
                  context.read<WeatherBloc>().add(GetWeatherEvent(city));
                }
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 32),

            // UI CHANGES BASED ON WEATHER STATE
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherBlocLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherBlocSuccessState) {
                  final weather = state.weather;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'City: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            weather.city,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Description: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            weather.description,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Temperature: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${weather.temperature} °F',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is WeatherBlocFailureState) {
                  return const Text(
                    'Something went wrong. Try another city.',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return const Text('Enter a city name to get started.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
