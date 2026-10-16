import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/movie_catalog/data/sources/movie_catalog_remote_data_source.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/repository/movie_catalog_repository.dart';

class MovieCatalogRepositoryImpl implements MovieCatalogRepository {
  final MovieCatalogRemoteDataSource remoteDataSource;

  MovieCatalogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<MovieEntity>>> getTrendingMovies() async {
    final result = await remoteDataSource.getTmdbTrendingMovies();

    return result.fold(
      (error) async => Left<String, List<MovieEntity>>(error),
      (movies) async => Right<String, List<MovieEntity>>(movies),
    );
  }

  @override
  Future<Either<String, List<MovieEntity>>> getTopRatedMovies() async {
    final result = await remoteDataSource.getTopRatedMovies();

    return result.fold(
      (error) async => Left<String, List<MovieEntity>>(error),
      (movies) async => Right<String, List<MovieEntity>>(movies),
    );
  }
}
