import 'package:plotline_mobile/features/history/domain/entity/history_entity.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> history;
  final bool hasMore;
  final bool isLoadingMore;

  HistoryLoaded({
    required this.history,
    required this.hasMore,
    this.isLoadingMore = false,
  });
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}
