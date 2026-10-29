import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';

class WatchlistResultEntity {
  final List<WatchlistEntity> items;
  final bool hasMore;

  const WatchlistResultEntity({required this.items, required this.hasMore});
}
