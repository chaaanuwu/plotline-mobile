import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/history/domain/usecases/get_history_usecase.dart';
import 'package:plotline_mobile/features/history/presentation/cubit/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryUsecase getHistoryUsecase;

  HistoryCubit({required this.getHistoryUsecase}) : super(HistoryInitial());

  int _currentPage = 1;

  Future<void> getHistory(String? userId) async {
    _currentPage = 1;
    emit(HistoryLoading());

    final result = await getHistoryUsecase(
      GetHistoryParams(userId: userId, page: _currentPage),
    );

    result.fold(
      (error) {
        emit(HistoryError(message: error));
      },
      (result) {
        emit(HistoryLoaded(history: result.items, hasMore: result.hasMore));
      },
    );
  }

  Future<void> loadMore(String? userId) async {
    final currentState = state;

    if (currentState is! HistoryLoaded ||
        !currentState.hasMore ||
        currentState.isLoadingMore) {
      return;
    }

    emit(
      HistoryLoaded(
        history: currentState.history,
        hasMore: currentState.hasMore,
        isLoadingMore: true,
      ),
    );

    final nextPage = _currentPage + 1;

    final result = await getHistoryUsecase(
      GetHistoryParams(userId: userId, page: nextPage),
    );

    result.fold(
      (error) {
        emit(
          HistoryLoaded(
            history: currentState.history,
            hasMore: currentState.hasMore,
          ),
        );
      },
      (result) {
        _currentPage = nextPage;

        emit(
          HistoryLoaded(
            history: [...currentState.history, ...result.items],
            hasMore: result.hasMore,
          ),
        );
      },
    );
  }
}
