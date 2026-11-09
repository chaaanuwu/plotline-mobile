import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieEntity movie;

  // Profile cover
  final ProfileCoverStatus profileCoverStatus;
  final String? profileCoverError;

  // History
  final bool isInHistory;
  final bool isHistoryLoading;
  final String? historyError;

  // Watchlist
  final bool isWatchlisted;
  final bool isWatchlistLoading;
  final String? watchlistError;

  MovieDetailsLoaded({
    required this.movie,

    // Profile cover
    this.profileCoverStatus = ProfileCoverStatus.initial,
    this.profileCoverError,

    // History
    this.isInHistory = false,
    this.isHistoryLoading = true,
    this.historyError,

    // Watchlist
    this.isWatchlisted = false,
    this.isWatchlistLoading = true,
    this.watchlistError,
  });

  MovieDetailsLoaded copyWith({
    MovieEntity? movie,

    // Profile cover
    ProfileCoverStatus? profileCoverStatus,
    String? profileCoverError,
    bool clearProfileCoverError = false,

    // History
    bool? isInHistory,
    bool? isHistoryLoading,
    String? historyError,
    bool clearHistoryError = false,

    // Watchlist
    bool? isWatchlisted,
    bool? isWatchlistLoading,
    String? watchlistError,
    bool clearWatchlistError = false,
  }) {
    return MovieDetailsLoaded(
      movie: movie ?? this.movie,

      // Profile cover
      profileCoverStatus: profileCoverStatus ?? this.profileCoverStatus,
      profileCoverError: clearProfileCoverError
          ? null
          : profileCoverError ?? this.profileCoverError,

      // History
      isInHistory: isInHistory ?? this.isInHistory,
      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,
      historyError: clearHistoryError
          ? null
          : historyError ?? this.historyError,

      // Watchlist
      isWatchlisted: isWatchlisted ?? this.isWatchlisted,
      isWatchlistLoading: isWatchlistLoading ?? this.isWatchlistLoading,
      watchlistError: clearWatchlistError
          ? null
          : watchlistError ?? this.watchlistError,
    );
  }
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}

enum ProfileCoverStatus { initial, loading, success, error }
