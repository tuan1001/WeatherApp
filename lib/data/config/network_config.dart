// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:onboarding_concept/data/remote/api_endPoints.dart';

abstract class NetworkConfig {
  final String baseUrl;
  int connectTimeout;
  int receiveTimeout;
  Map<String, dynamic> headers;
  NetworkConfig.internal({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.headers,
  });

  factory NetworkConfig({required String buildMode, required String token}) {
    return Config(
      baseUrl: ApiEndPoints.baseUrl,
      headers: {
        ApiEndPoints.contentType: ApiEndPoints.contentTypeJson,
        ApiEndPoints.authorization: 'Bearer $token',
      },
    );
  }
}

class Config extends NetworkConfig {
  Config({
    required String baseUrl,
    required Map<String, dynamic> headers,
    int connectTimeout = ApiEndPoints.connectTimeout,
    int receiveTimeout = ApiEndPoints.receiveTimeout,
  }) : super.internal(
          baseUrl: baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          headers: headers,
        );
}
