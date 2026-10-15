import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/repository/movie_catalog_repository.dart';

class GetTopRatedMoviesUsecase
    implements UseCase<Either<String, List<MovieEntity>>, NoParams> {
  final MovieCatalogRepository repository;

  GetTopRatedMoviesUsecase({required this.repository});

  @override
  Future<Either<String, List<MovieEntity>>> call(NoParams params) {
    return repository.getTopRatedMovies();
  }
}
