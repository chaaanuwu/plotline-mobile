import 'package:plotline_mobile/core/configs/api/api_config.dart';

class ApiEndpoints {
  static final String baseUrl = ApiConfig.plotlineApiBaseUrl;

  // AUTH
  static final String signinUrl = "$baseUrl/auth/sign-in";
  static final String signupUrl = "$baseUrl/auth/sign-up";

  // MOVIES
  static final String trendingMovies = "$baseUrl/tmdb/trending";
  static final String topRatedMovies = "$baseUrl/tmdb/top-rated";
  static String searchMovies(String title) =>
      "$baseUrl/movies/search?q=${Uri.encodeQueryComponent(title.trim())}"; // Search movie by title

  // PROFILE - ME
  static final String userMeProfile = "$baseUrl/profile/me";

  // EDIT - PROFILE
  static final String editProfile = "$baseUrl/user/me/edit";

  //REVIEWS - FEED
  static final String feedReviews = "$baseUrl/feed";

  // REVIEWS - ME
  static final String myReviews = "$baseUrl/reviews";
}
