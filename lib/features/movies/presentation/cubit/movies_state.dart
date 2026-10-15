import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> trendingMovies;

  MoviesLoaded(this.trendingMovies);
}

class MoviesError extends MoviesState {
  final String message;

  MoviesError(this.message);
}
