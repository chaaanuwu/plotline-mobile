import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageConfig {
  static String get tmdbBackdropBaseUrl =>
      dotenv.env['TMDB_BACKDROP_BASE_URL'] ?? '';

  static String get tmdbPosterBaseUrl =>
      dotenv.env['TMDB_POSTER_BASE_URL'] ?? '';
}
