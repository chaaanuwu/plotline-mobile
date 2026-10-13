import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.movieId,
    required super.tmdbId,
    required super.title,
    required super.originalTitle,
    required super.adult,
    required super.genres,
    required super.originalLanguage,
    required super.overview,
    required super.releaseDate,
    required super.posterPath,
    required super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json['_id'],
      tmdbId: json['tmdbId'],
      title: json['title'],
      originalTitle: json['originalTitle'],
      adult: json['adult'],
      genres: List<String>.from(json['genres'] ?? []),
      originalLanguage: json['originalLanguage'],
      overview: json['overview'],
      releaseDate: json['releaseDate'],
      posterPath: json['posterPath'],
      backdropPath: json['backdropPath'],
      voteAverage: json['voteAverage'],
      voteCount: json['voteCount'],
    );
  }
}
