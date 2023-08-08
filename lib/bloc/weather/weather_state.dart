// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:onboarding_concept/data/model/weather.dart';

class WeatherState extends Equatable {
  WeatherStatus status;
  String message;
  String token;
  String error;
  Weather weather;

  WeatherState({
    required this.status,
    required this.message,
    required this.error,
    required this.token,
    required this.weather,
  });
  WeatherState.initial()
      : this(
            status: WeatherStatus.initial,
            weather: Weather(current: Current(condition: Condition()), location: Location(), forecast: Forecast(forecastday: [])),
            message: '',
            error: '',
            token: '');
  WeatherState copyWith({
    WeatherStatus? status,
    String? message,
    String? error,
    String? token,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
      token: token ?? this.token,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        error,
      ];
}

enum WeatherStatus {
  initial,
  loading,
  error,
  getSuccess,
}
