import 'package:dio/dio.dart';

class Api {
  static api() {
    final options = BaseOptions(
      baseUrl: 'http://10.0.2.2:5000/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    return Dio(options);
  }
}
