import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onboarding_concept/data/di/injector.dart';
import 'package:onboarding_concept/repository/weather/WeatherRepo.dart';

import 'weather_state.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<GetWeather>(_getWeather);
    on<GetForecast>(_getForecast);
  }
  FutureOr<void> _getWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    final res = await injector<WeatherRepository>().getWeather(
      event.q,
    );
    if (res.error != {}) {
      print('object');
      emit(state.copyWith(status: WeatherStatus.getSuccess, weather: res));
    } else {
      emit(state.copyWith(status: WeatherStatus.error, error: res.error.message));
    }
  }

  FutureOr<void> _getForecast(GetForecast event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    final res = await injector<WeatherRepository>().getForecast(
      event.q,
      event.day,
      event.hour,
    );
    if (res.error.message == null) {
      print('object');
      print(res.error.message);
      emit(state.copyWith(status: WeatherStatus.getSuccess, weather: res));
    } else {
      print('object1');
      print(res.error.toString());
      emit(state.copyWith(status: WeatherStatus.error, error: res.error.message));
    }
  }
}
