import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app_bloc_02/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  Widget getWeatherIcon(int code) {
    if (code >= 200 && code < 300) {
      return Image.asset('assets/1.png');
    } else if (code >= 300 && code < 400) {
      return Image.asset('assets/2.png');
    } else if (code >= 500 && code < 600) {
      return Image.asset('assets/3.png');
    } else if (code >= 600 && code < 700) {
      return Image.asset('assets/4.png');
    } else if (code >= 700 && code < 800) {
      return Image.asset('assets/5.png');
    } else if (code == 800) {
      return Image.asset('assets/6.png');
    } else if (code > 800 && code <= 804) {
      return Image.asset('assets/7.png');
    } else {
      return Image.asset('assets/7.png');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch Manila weather on app start
    context.read<WeatherBloc>().add(GetWeatherEvent('Manila'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        // Default text color and background image path
        Color textColor = Colors.black;
        String backgroundImage = 'assets/morningBg.jpg';

        Widget child;

        if (state is WeatherBlocLoadingState) {
          child = const Center(child: CircularProgressIndicator());
        } else if (state is WeatherBlocSuccessState) {
          final weather = state.weather;

          // Use night background and white text for PM, else morning bg and black text for AM
          if (weather.amPm.toLowerCase() == 'pm') {
            backgroundImage = 'assets/nightBg.jpg';
            textColor = Colors.white;
          } else {
            backgroundImage = 'assets/morningBg.jpg';
            textColor = Colors.black;
          }

          child = SafeArea(
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
                  Center(child: getWeatherIcon(weather.weatherCodes)),

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
                      weather.formattedTime,
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
                    controller: _controller,
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
                        final city = _controller.text.trim();
                        if (city.isNotEmpty) {
                          context.read<WeatherBloc>().add(
                            GetWeatherEvent(city),
                          );
                        }
                        _controller.clear();
                      },
                      child: Text('Search', style: TextStyle(color: textColor)),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else if (state is WeatherBlocFailureState) {
          // Show error with default colors (red text) and input for retry
          child = Padding(
            padding: const EdgeInsets.all(28.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Something went wrong. Try another city.',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final city = _controller.text.trim();
                      if (city.isNotEmpty) {
                        context.read<WeatherBloc>().add(GetWeatherEvent(city));
                      }
                      _controller.clear();
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Fallback UI for initial or other states with default colors
          child = Padding(
            padding: const EdgeInsets.all(28.0),
            child: Center(
              child: Column(
                children: [
                  const Text('Enter a city name to get started.'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final city = _controller.text.trim();
                      if (city.isNotEmpty) {
                        context.read<WeatherBloc>().add(GetWeatherEvent(city));
                      }
                      _controller.clear();
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar:
              true, // This makes body fill entire screen behind app bar
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: textColor == Colors.white
                  ? Brightness.dark
                  : Brightness.light,
              statusBarIconBrightness: textColor == Colors.white
                  ? Brightness.light
                  : Brightness.dark,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(child: child),
          ),
        );
      },
    );
  }
}
