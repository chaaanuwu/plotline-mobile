import 'package:plotline_mobile/features/reviews/domain/entity/review_movie_entity.dart';

class ReviewMovieModel extends ReviewMovieEntity {
  ReviewMovieModel({
    required super.movieId,
    required super.title,
    required super.backdropPath,
    required super.posterPath,
    required super.genres,
    required super.releaseDate,
  });

  factory ReviewMovieModel.fromJson(Map<String, dynamic> json) {
    return ReviewMovieModel(
      movieId: json['_id'],
      title: json['title'],
      backdropPath: json['backdropPath'],
      posterPath: json['posterPath'],
      genres: List<String>.from(json['genreNames'] ?? []),
      releaseDate: json['releaseDate'],
    );
  }
}
