import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_trending_movies_usecase.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetTrendingMoviesUsecase getTrendingMoviesUsecase;

  MoviesCubit({required this.getTrendingMoviesUsecase})
    : super(MoviesInitial());

  Future<void> getTrendingMovies() async {
    emit(MoviesLoading());

    final result = await getTrendingMoviesUsecase(NoParams());

    result.fold(
      (failure) {
        debugPrint('Trending API failed: $failure');
        emit(MoviesError(failure));
      },
      (movies) {
        debugPrint('Trending movie count: ${movies.length}');
        debugPrint('Trending movies: $movies');
        emit(MoviesLoaded(movies));
      },
    );
  }
}
