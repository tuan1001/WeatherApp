import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_concept/data/apis/weather_api.dart';
import 'package:onboarding_concept/data/config/store_local.dart';
import 'package:onboarding_concept/data/remote/dio_intercerceptors.dart';
import 'package:onboarding_concept/data/config/network_config.dart';
import 'package:onboarding_concept/global_variable.dart';
import 'package:onboarding_concept/repository/weather/WeatherRepo.dart';

mixin ApiDI {
  static Future<void> init(GetIt injector) async {
    injector..registerLazySingleton<RestClient>(() => RestClient(injector<Dio>()));
  }
}

mixin RepositoryDI {
  static Future<void> init(GetIt injector) async {
    injector..registerLazySingleton<WeatherRepository>(() => WeatherRepository(injector<RestClient>()));
  }
}
mixin NetWorkDI {
  static Future<void> init(GetIt injector, {required String buildMode}) async {
    injector.registerLazySingleton<NetworkConfig>(() => NetworkConfig(buildMode: buildMode, token: token!));
    injector.registerLazySingleton<CustomInterceptors>(() => CustomInterceptors());
    injector.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: injector<NetworkConfig>().baseUrl,
          headers: injector<NetworkConfig>().headers,
          connectTimeout: Duration(milliseconds: injector<NetworkConfig>().connectTimeout),
          receiveTimeout: Duration(milliseconds: injector<NetworkConfig>().receiveTimeout),
        ),
      )..interceptors.add(injector<CustomInterceptors>()),
    );
  }
}
mixin LocalDI {
  static Future<void> init(GetIt injector) async => await StoreLocal.getInstance();
}
