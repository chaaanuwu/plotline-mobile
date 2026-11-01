import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/watchlist/domain/usecase/get_watchlist_usecase.dart';
import 'package:plotline_mobile/features/watchlist/presentation/cubit/watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistUsecase getWatchlistUsecase;

  WatchlistCubit({required this.getWatchlistUsecase})
    : super(WatchlistInitial());

  int _currentPage = 1;

  Future<void> getWatchlist(String? userId) async {
    _currentPage = 1;
    emit(WatchlistLoading());

    final result = await getWatchlistUsecase(
      GetWatchlistParams(userId: userId, page: _currentPage),
    );

    result.fold(
      (error) {
        emit(WatchlistError(message: error));
      },
      (result) {
        emit(WatchlistLoaded(watchlist: result.items, hasMore: result.hasMore));
      },
    );
  }

  Future<void> loadMore(String? userId) async {
    final currentState = state;

    if (currentState is! WatchlistLoaded ||
        !currentState.hasMore ||
        currentState.isLoadingMore) {
      return;
    }

    emit(
      WatchlistLoaded(
        watchlist: currentState.watchlist,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    final nextPage = _currentPage + 1;

    final result = await getWatchlistUsecase(
      GetWatchlistParams(userId: userId, page: nextPage),
    );

    result.fold(
      (error) {
        emit(
          WatchlistLoaded(
            watchlist: currentState.watchlist,
            hasMore: currentState.hasMore,
          ),
        );
      },
      (result) {
        _currentPage = nextPage;

        emit(
          WatchlistLoaded(
            watchlist: [...currentState.watchlist, ...result.items],
            hasMore: result.hasMore,
          ),
        );
      },
    );
  }
}
