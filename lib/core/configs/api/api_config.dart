import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get plotlineApiBaseUrl {
    return dotenv.env['PLOTLINE_API_BASE_URL'] ?? '';
  }
}
