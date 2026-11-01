import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_movie_by_id_usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/update_profile_cover_usecase.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_state.dart';
import 'package:plotline_mobile/features/watchlist/domain/usecase/get_is_in_watchlist_usecase.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieByIdUsecase getMovieByIdUsecase;
  final UpdateProfileCoverUsecase updateProfileCoverUsecase;
  final GetIsInWatchlistUsecase isMovieWatchlistedUsecase;

  MovieDetailsCubit({
    required this.getMovieByIdUsecase,
    required this.updateProfileCoverUsecase,
    required this.isMovieWatchlistedUsecase,
  }) : super(MovieDetailsInitial());

  // Load movie details using movie ID
  Future<void> loadMovieById(String movieId) async {
    emit(MovieDetailsLoading());

    final result = await getMovieByIdUsecase(movieId);

    if (isClosed) return;

    await result.fold(
      (error) async {
        emit(MovieDetailsError(error));
      },
      (movie) async {
        emit(MovieDetailsLoaded(movie: movie, isWatchlistLoading: true));

        await checkWatchlistStatus(movie.movieId);
      },
    );
  }

  // Initialize with an existing movie
  Future<void> initialize(MovieEntity movie) async {
    emit(MovieDetailsLoaded(movie: movie, isWatchlistLoading: true));

    await checkWatchlistStatus(movie.movieId);
  }

  // Check whether movie is in watchlist
  Future<void> checkWatchlistStatus(String movieId) async {
    final currentState = state;

    if (currentState is! MovieDetailsLoaded) return;

    if (currentState.movie.movieId != movieId) return;

    emit(
      currentState.copyWith(
        isWatchlistLoading: true,
        clearWatchlistError: true,
      ),
    );

    final result = await isMovieWatchlistedUsecase(
      IsInWatchlistParams(movieId: movieId),
    );

    if (isClosed) return;

    final latestState = state;

    if (latestState is! MovieDetailsLoaded) return;

    if (latestState.movie.movieId != movieId) return;

    debugPrint('========== WATCHLIST DEBUG ==========');
    debugPrint('Movie ID: $movieId');

    result.fold(
      (error) {
        emit(
          latestState.copyWith(
            isWatchlistLoading: false,
            watchlistError: error,
          ),
        );
        debugPrint('Watchlist error: $error');
      },
      (isWatchlisted) {
        emit(
          latestState.copyWith(
            isWatchlisted: isWatchlisted,
            isWatchlistLoading: false,
            clearWatchlistError: true,
          ),
        );
        debugPrint('Watchlist result: $isWatchlisted');
      },
    );
    debugPrint('=====================================');
  }

  // Update profile cover using movie backdrop
  Future<void> updateProfileCover() async {
    final currentState = state;

    if (currentState is! MovieDetailsLoaded) return;

    if (currentState.profileCoverStatus == ProfileCoverStatus.loading) {
      return;
    }

    final movie = currentState.movie;

    if (movie.backdropPath.isEmpty) {
      emit(
        currentState.copyWith(
          profileCoverStatus: ProfileCoverStatus.error,
          profileCoverError: 'This movie has no backdrop available.',
        ),
      );
      return;
    }

    emit(
      currentState.copyWith(
        profileCoverStatus: ProfileCoverStatus.loading,
        clearProfileCoverError: true,
      ),
    );

    final result = await updateProfileCoverUsecase(movie.backdropPath);

    if (isClosed) return;

    final latestState = state;

    if (latestState is! MovieDetailsLoaded) return;

    result.fold(
      (error) {
        emit(
          latestState.copyWith(
            profileCoverStatus: ProfileCoverStatus.error,
            profileCoverError: error,
          ),
        );
      },
      (_) {
        emit(
          latestState.copyWith(
            profileCoverStatus: ProfileCoverStatus.success,
            clearProfileCoverError: true,
          ),
        );
      },
    );
  }
}
