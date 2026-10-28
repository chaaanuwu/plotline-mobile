import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/repository/movie_catalog_repository.dart';

class GetSearchMovieResultsUsecase
    implements UseCase<Either<String, List<MovieEntity>>, String> {
  final MovieCatalogRepository repository;

  GetSearchMovieResultsUsecase({required this.repository});

  @override
  Future<Either<String, List<MovieEntity>>> call(String params) {
    return repository.searchMovies(params);
  }
}
