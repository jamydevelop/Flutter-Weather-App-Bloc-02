part of 'weather_bloc.dart';

@immutable
sealed class FetchWeatherEvent {}

/// This event gets triggered when the user enters a city name.
/// It carries the city name to the BLoC.
final class GetWeatherEvent extends FetchWeatherEvent {
  final String city;

  GetWeatherEvent(this.city);
}
