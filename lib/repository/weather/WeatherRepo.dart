// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:onboarding_concept/data/apis/weather_api.dart';
import 'package:onboarding_concept/data/model/weather.dart';
import 'package:onboarding_concept/data/remote/api_endPoints.dart';

import 'package:onboarding_concept/data/remote/dio_intercerceptors.dart';

class WeatherRepository {
  final RestClient _restClient;
  WeatherRepository(this._restClient);
  Future<Weather> getWeather(dynamic q) async {
    //return await sendRequest(_restClient.getWeather({}, {'q': q, 'key': key}));
    try {
      final res = await _restClient.getWeather({}, {'q': q, 'key': ApiEndPoints.key});
      return Weather.fromJson(res.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
