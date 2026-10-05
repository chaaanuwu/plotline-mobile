import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:plotline_mobile/core/configs/api/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio dio;
  final SharedPreferences prefs;

  ApiClient({required this.prefs})
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.plotlineApiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final isPublicEndpoint = options.path.contains('auth');

          if (!isPublicEndpoint) {
            final authJson = prefs.getString('auth_data');

            if (authJson != null && authJson.isNotEmpty) {
              try {
                final authData = jsonDecode(authJson);

                if (authData is Map) {
                  final token = authData['token']?.toString();

                  if (token != null && token.isNotEmpty) {
                    options.headers['Authorization'] = 'Bearer $token';

                    print('API: Token attached');
                  }
                }
              } catch (e) {
                print('API: Failed to read auth token: $e');
              }
            }
          }

          handler.next(options);
        },
      ),
    );
  }
}