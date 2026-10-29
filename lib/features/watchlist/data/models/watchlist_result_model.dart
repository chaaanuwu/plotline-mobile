import 'package:plotline_mobile/features/watchlist/data/models/watchlist_model.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_result_entity.dart';

class WatchlistResultModel extends WatchlistResultEntity {
  const WatchlistResultModel({required super.items, required super.hasMore});

  factory WatchlistResultModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;

    return WatchlistResultModel(
      items: data
          .map(
            (item) =>
                WatchlistModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
      hasMore: json['hasMore'] as bool,
    );
  }
}
