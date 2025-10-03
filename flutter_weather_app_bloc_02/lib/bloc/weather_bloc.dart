import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app_bloc_02/services/weather_service.dart';
import 'package:meta/meta.dart';

import 'package:flutter_weather_app_bloc_02/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<FetchWeatherEvent, WeatherState> {
  final WeatherService _weatherService =
      WeatherService(); // create service instance

  WeatherBloc() : super(WeatherBlocInitialState()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherBlocLoadingState()); // show loading

      try {
        // Fetch data from API using the city passed in event
        final weatherJson = await _weatherService.fetchWeather(event.city);

        // Convert raw JSON into Weather model
        final weather = Weather.fromJson(weatherJson);

        // Emit success state with weather data
        emit(WeatherBlocSuccessState(weather));
      } catch (e) {
        // If something goes wrong, show failure state
        print('ERROR: $e');
        emit(WeatherBlocFailureState());
      }
    });
  }
}
