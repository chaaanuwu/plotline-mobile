import 'package:plotline_mobile/features/history/domain/entity/history_movie_entity.dart';

class HistoryEntity {
  final String id;
  final String userId;
  final HistoryMovieEntity movie;
  final String watchedAt;

  HistoryEntity({
    required this.id,
    required this.userId,
    required this.movie,
    required this.watchedAt,
  });
}
