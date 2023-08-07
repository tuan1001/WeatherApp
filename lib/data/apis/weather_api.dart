import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'weather_api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET('')
  Future<HttpResponse<dynamic>> getWeather(@Body() Map<String, dynamic> body, @Queries() Map<String, dynamic> queries);
}
