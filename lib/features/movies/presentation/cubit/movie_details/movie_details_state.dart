import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieEntity movie;

  // Profile cover
  final ProfileCoverStatus profileCoverStatus;
  final String? profileCoverError;

  // Watchlist
  final bool isWatchlisted;
  final bool isWatchlistLoading;
  final String? watchlistError;

  MovieDetailsLoaded({
    required this.movie,
    this.profileCoverStatus = ProfileCoverStatus.initial,
    this.profileCoverError,
    this.isWatchlisted = false,
    this.isWatchlistLoading = true,
    this.watchlistError,
  });

  MovieDetailsLoaded copyWith({
    MovieEntity? movie,
    ProfileCoverStatus? profileCoverStatus,
    String? profileCoverError,
    bool clearProfileCoverError = false,
    bool? isWatchlisted,
    bool? isWatchlistLoading,
    String? watchlistError,
    bool clearWatchlistError = false,
  }) {
    return MovieDetailsLoaded(
      movie: movie ?? this.movie,
      profileCoverStatus: profileCoverStatus ?? this.profileCoverStatus,
      profileCoverError: clearProfileCoverError
          ? null
          : profileCoverError ?? this.profileCoverError,
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
