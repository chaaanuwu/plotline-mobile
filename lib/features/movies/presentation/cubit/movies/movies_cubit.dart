import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/usecase/get_trending_movies_usecase.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movies/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetTrendingMoviesUsecase getTrendingMoviesUsecase;
  final GetTopRatedMoviesUsecase getTopRatedMoviesUsecase;

  MoviesCubit({
    required this.getTrendingMoviesUsecase,
    required this.getTopRatedMoviesUsecase,
  }) : super(MoviesInitial());

  Future<void> getMovieCatalog() async {
    emit(MoviesLoading());

    final results = await Future.wait([
      getTrendingMoviesUsecase(NoParams()),
      getTopRatedMoviesUsecase(NoParams()),
    ]);

    final trendingResult = results[0];
    final topRatedResult = results[1];

    List<MovieEntity> trendingMovies = [];
    List<MovieEntity> topRatedMovies = [];
    bool trendingFailed = false;
    bool topRatedFailed = false;

    trendingResult.fold(
      (failure) {
        debugPrint('Trending API failed: $failure');
        trendingFailed = true;
      },
      (movies) {
        trendingMovies = movies;
      },
    );

    topRatedResult.fold(
      (failure) {
        debugPrint('Top Rated API failed: $failure');
        topRatedFailed = true;
      },
      (movies) {
        topRatedMovies = movies;
      },
    );

    if (trendingFailed && topRatedFailed) {
      trendingResult.fold(
        (failure) => emit(MoviesError(failure)),
        (_) {},
      );
      return;
    }

    emit(MoviesLoaded(
      trendingMovies: trendingMovies,
      topRatedMovies: topRatedMovies,
    ));
  }
}
