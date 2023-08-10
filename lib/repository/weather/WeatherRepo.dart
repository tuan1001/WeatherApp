// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:onboarding_concept/data/apis/weather_api.dart';
import 'package:onboarding_concept/data/model/weather.dart';
import 'package:onboarding_concept/data/remote/api_endPoints.dart';

class WeatherRepository {
  final RestClient _restClient;
  WeatherRepository(this._restClient);
  Future<Weather> getWeather(dynamic q) async {
    try {
      final res = await _restClient.getWeather({}, {'q': q, 'key': ApiEndPoints.key});
      return Weather.fromJson(res.data);
    } on DioError catch (e) {
      return Weather.fromJson(e.response!.data);
    }
  }

  Future<Weather> getForecast(dynamic q, dynamic day, dynamic hour) async {
    try {
      final res = await _restClient.getForecast({}, {'q': q, 'days': day, 'hour': hour, 'key': ApiEndPoints.key});
      return Weather.fromJson(res.data);
    } on DioError catch (e) {
      return Weather.fromJson(e.response!.data);
    }
  }
}
