part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitialState extends WeatherState {}

final class WeatherBlocLoadingState extends WeatherState {}

final class WeatherBlocFailureState extends WeatherState {}

final class WeatherBlocSuccessState extends WeatherState {
  final WeatherModel weather;

  const WeatherBlocSuccessState(this.weather);

  @override
  List<Object> get props => [weather];
}
