part of 'weather_bloc.dart';

@immutable
class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final dynamic q;

  GetWeather({
    required this.q,
  });
}

class GetForecast extends WeatherEvent {
  final dynamic q;
  final dynamic day;
  final dynamic hour;

  GetForecast({
    required this.q,
    required this.day,
    required this.hour,
  });
}
