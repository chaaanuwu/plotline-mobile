import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_movie_entity.dart';

class WatchlistMovieModel extends WatchlistMovieEntity {
  WatchlistMovieModel({
    required super.movieId,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.genres,
  });

  factory WatchlistMovieModel.fromJson(Map<String, dynamic> json) =>
      WatchlistMovieModel(
        movieId: json['movieId'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['posterPath'],
        releaseDate: json['releaseDate'],
        genres: List<String>.from(json['genreNames'] ?? []),
      );
}
