import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _initializeInterceptors();
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          /// token local storage/shared pref se lo
          String? token = await getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          /// LOGS
          debugPrint("╔════════════════ REQUEST ════════════════");

          debugPrint("➡️ URL : ${options.baseUrl}${options.path}");

          debugPrint("➡️ METHOD : ${options.method}");

          debugPrint("➡️ HEADERS : ${options.headers}");

          debugPrint("➡️ QUERY : ${options.queryParameters}");

          debugPrint("➡️ BODY : ${options.data}");

          debugPrint("╚═════════════════════════════════════════");

          return handler.next(options);
        },

        /// RESPONSE
        onResponse: (response, handler) {
          debugPrint("╔════════════════ RESPONSE ═══════════════");

          debugPrint("✅ STATUS CODE : ${response.statusCode}");

          debugPrint("✅ URL : ${response.requestOptions.uri}");

          debugPrint("✅ RESPONSE : ${response.data}");

          debugPrint("╚═════════════════════════════════════════");

          return handler.next(response);
        },

        /// ERROR
        onError: (DioException e, handler) {
          debugPrint("╔════════════════ ERROR ══════════════════");

          debugPrint("❌ URL : ${e.requestOptions.uri}");

          debugPrint("❌ ERROR : ${e.message}");

          debugPrint("❌ TYPE : ${e.type}");

          debugPrint("❌ STATUS CODE : ${e.response?.statusCode}");

          debugPrint("❌ RESPONSE : ${e.response?.data}");

          debugPrint("╚═════════════════════════════════════════");

          return handler.next(e);
        },
      ),
    );
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? customBaseUrl,
  }) async {
    final String finalUrl = customBaseUrl != null ? "$customBaseUrl$url" : url;

    return await dio.post(
      finalUrl,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> put(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
      }) async {

    return await dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
