import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app_bloc_02/bloc/weather_bloc.dart';
import 'package:flutter_weather_app_bloc_02/models/weather.dart';
import 'package:flutter_weather_app_bloc_02/views/widgets/failure_state_widget.dart';
import 'package:flutter_weather_app_bloc_02/views/widgets/initial_state_widget.dart';
import 'package:flutter_weather_app_bloc_02/views/widgets/success_state_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(GetWeatherEvent('Manila'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        // Default values
        Color textColor = Colors.black;
        String backgroundImage = 'assets/morningBg.jpg';

        Widget child;

        if (state is WeatherBlocLoadingState) {
          child = const Center(child: CircularProgressIndicator());
        } else if (state is WeatherBlocSuccessState) {
          final Weather weather = state.weather;

          // Switch to night theme if PM
          if (weather.amPm.toLowerCase() == 'pm') {
            backgroundImage = 'assets/nightBg.jpg';
            textColor = Colors.white;
          } else {
            backgroundImage = 'assets/morningBg.jpg';
            textColor = Colors.black;
          }
          child = SuccessStateWidget(
            weather: weather,
            textColor: textColor,
            controller: _controller,
          );
        } else if (state is WeatherBlocFailureState) {
          // Error UI
          child = FailureStateWidget(controller: _controller);
        } else {
          // Initial state
          child = InitialStateWidget(controller: _controller);
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
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
