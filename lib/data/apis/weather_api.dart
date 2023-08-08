import 'package:dio/dio.dart';
import 'package:onboarding_concept/data/remote/api_endPoints.dart';
import 'package:retrofit/retrofit.dart';
part 'weather_api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET(ApiEndPoints.getCurrent)
  Future<HttpResponse<dynamic>> getWeather(@Body() Map<String, dynamic> body, @Queries() Map<String, dynamic> queries);

  @GET(ApiEndPoints.getForecast)
  Future<HttpResponse<dynamic>> getForecast(@Body() Map<String, dynamic> body, @Queries() Map<String, dynamic> queries);
}
