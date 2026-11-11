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
  static String getMovieById(String id) =>
      "$baseUrl/movies/$id"; // Get movie by id

  // PROFILE
  // CURRENT USER
  static String userMeProfile = "$baseUrl/profile/me";
  // USER
  static String userProfile(String userId) {
    return "$baseUrl/user/$userId";
  }

  // WATCHLIST
  static String watchlist([String? userId]) {
    return userId == null ? "$baseUrl/watchlist" : "$baseUrl/watchlist/$userId";
  }

  static String isWatchlisted(String movieId) =>
      "$baseUrl/watchlist/movie/$movieId"; // Check if movie is watchlisted

  // HISTORY
  static String history([String? userId]) {
    return userId == null ? "$baseUrl/history" : "$baseUrl/history/$userId";
  }

  static String isWatched(String movieId) =>
      "$baseUrl/history/movie/$movieId"; // Check if movie is in history

  // EDIT - PROFILE
  static final String editProfile = "$baseUrl/user/me/edit";

  //REVIEWS
  // FEED
  static final String feedReviews = "$baseUrl/feed";
  // ME
  static final String myReviews = "$baseUrl/reviews";
  // USER
  static String userReviews(String userId) => "$baseUrl/users/$userId/reviews";
}
