import 'package:plotline_mobile/core/configs/api/api_config.dart';

class ApiEndpoints {
  static final String baseUrl = ApiConfig.plotlineApiBaseUrl;

  static final String signinUrl = "$baseUrl/auth/sign-in";
}