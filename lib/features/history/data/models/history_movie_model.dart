import 'package:plotline_mobile/features/history/domain/entity/history_movie_entity.dart';

class HistoryMovieModel extends HistoryMovieEntity {
  HistoryMovieModel({
    required super.movieId,
    required super.title,
    required super.posterPath,
    required super.releaseDate,
  });

  factory HistoryMovieModel.fromJson(Map<String, dynamic> json) =>
      HistoryMovieModel(
        movieId: json['_id'],
        title: json['title'],
        posterPath: json['posterPath'],
        releaseDate: json['releaseDate'],
      );
}
