import 'package:plotline_mobile/features/watchlist/data/models/watchlist_movie_model.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';

class WatchlistModel extends WatchlistEntity {
  WatchlistModel({
    required super.id,
    required super.userId,
    required super.movie,
    required super.createdAt,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) => WatchlistModel(
    id: json['id'] as String,
    userId: json['userId'] as String,
    movie: WatchlistMovieModel.fromJson(
      Map<String, dynamic>.from(json['movieId']),
    ),
    createdAt: json['createdAt'] as String,
  );
}
