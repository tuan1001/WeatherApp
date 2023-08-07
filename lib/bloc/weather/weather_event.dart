part of 'weather_bloc.dart';

@immutable
class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final dynamic q;

  GetWeather({
    required this.q,
  });
}
