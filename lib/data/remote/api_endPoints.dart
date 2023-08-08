// ignore_for_file: file_names

mixin ApiEndPoints {
  //ApiEndPoints._();

  static const String baseUrl = 'http://api.weatherapi.com/v1';
  static const String key = '2ab990aad60a42689fb71643230608';

  static const int receiveTimeout = 30000;
  static const int connectTimeout = 30000;

  static const String contentType = 'Content-Type';
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'application/x-www-form-urlencoded';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String authorization = 'Authorization';

  //auth
  static const String getCurrent = '/current.json';
  static const String getForecast = '/forecast.json';
}
