import 'package:plotline_mobile/features/history/data/models/history_movie_model.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_entity.dart';

class HistoryModel extends HistoryEntity {
  HistoryModel({
    required super.id,
    required super.userId,
    required super.movie,
    required super.watchedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json['_id'],
    userId: json['userId'],
    movie: HistoryMovieModel.fromJson(
      Map<String, dynamic>.from(json['movieId'] as Map),
    ),
    watchedAt: json['watchedAt'],
  );
}
