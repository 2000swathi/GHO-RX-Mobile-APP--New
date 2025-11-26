import 'package:dio/dio.dart';
import 'env.dart';

class DioHandler {
  static final DioHandler _instance = DioHandler._internal();
  factory DioHandler() => _instance;

  final Dio _dio;

  DioHandler._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: Env.apiUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }
}
