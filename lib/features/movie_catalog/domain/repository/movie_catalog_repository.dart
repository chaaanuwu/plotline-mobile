import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

abstract class MovieCatalogRepository {
  Future<Either<String, List<MovieEntity>>> getTrendingMovies();

  Future<Either<String, List<MovieEntity>>> getTopRatedMovies();

  Future<Either<String, List<MovieEntity>>> searchMovies(String title);

  Future<Either<String, MovieEntity>> getMovieById(String id);

  Future<Either<String, Unit>> updateProfileCover(String backdropPath);
}
