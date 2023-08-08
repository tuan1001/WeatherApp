// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:onboarding_concept/data/remote/api_endPoints.dart';
import 'package:onboarding_concept/ui/utils/helpers/logger.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logDev.f("REQUEST[${options.method}] => PATH: ${ApiEndPoints.baseUrl}${options.path}\nDATA: ${options.data}\nPARAM: ${options.queryParameters}");
    return super.onRequest(options, handler); //continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDev.f("RESPONSE[${response.statusCode}] => PATH: ${response.realUri.path}\nDATA: ${response.data}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logDev.f("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}]\nDATA: ${err.response?.data}");
    return super.onError(err, handler);
  }
}

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
