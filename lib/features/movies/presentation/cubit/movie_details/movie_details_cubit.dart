
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_movie_by_id_usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/update_profile_cover_usecase.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieByIdUsecase getMovieByIdUsecase;
  final UpdateProfileCoverUsecase updateProfileCoverUsecase;

  MovieDetailsCubit({
    required this.getMovieByIdUsecase,
    required this.updateProfileCoverUsecase,
  }) : super(MovieDetailsInitial());

  Future<void> loadMovieById(String movieId) async {
    emit(MovieDetailsLoading());

    final result = await getMovieByIdUsecase(movieId);

    if (isClosed) return;

    result.fold(
      (error) {
        emit(MovieDetailsError(error));
      },
      (movie) {
        emit(MovieDetailsLoaded(movie: movie));
      },
    );
  }

  void initialize(MovieEntity movie) {
    emit(MovieDetailsLoaded(movie: movie));
  }

  Future<void> updateProfileCover() async {
    final currentState = state;

    if (currentState is! MovieDetailsLoaded) return;

    if (currentState.profileCoverStatus == ProfileCoverStatus.loading) {
      return;
    }

    final movie = currentState.movie;

    if (movie.backdropPath.isEmpty) {
      emit(
        MovieDetailsLoaded(
          movie: movie,
          profileCoverStatus: ProfileCoverStatus.error,
          profileCoverError: 'This movie has no backdrop available.',
        ),
      );
      return;
    }

    emit(
      MovieDetailsLoaded(
        movie: movie,
        profileCoverStatus: ProfileCoverStatus.loading,
      ),
    );

    final result = await updateProfileCoverUsecase(movie.backdropPath);

    if (isClosed) return;

    result.fold(
      (error) {
        emit(
          MovieDetailsLoaded(
            movie: movie,
            profileCoverStatus: ProfileCoverStatus.error,
            profileCoverError: error,
          ),
        );
      },
      (_) {
        emit(
          MovieDetailsLoaded(
            movie: movie,
            profileCoverStatus: ProfileCoverStatus.success,
          ),
        );
      },
    );
  }
}
