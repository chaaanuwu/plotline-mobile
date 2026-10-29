import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistEntity> watchlist;
  final bool hasMore;
  final bool isLoadingMore;

  WatchlistLoaded({
    required this.watchlist,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError({required this.message});
}