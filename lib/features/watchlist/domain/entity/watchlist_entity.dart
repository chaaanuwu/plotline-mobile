import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_movie_entity.dart';

class WatchlistEntity {
  final String id;
  final String userId;
  final WatchlistMovieEntity movie;
  final String createdAt;

  WatchlistEntity({
    required this.id,
    required this.userId,
    required this.movie,
    required this.createdAt,
  });
}
