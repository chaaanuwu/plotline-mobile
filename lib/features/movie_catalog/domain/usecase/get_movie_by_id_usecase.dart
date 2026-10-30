import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/repository/movie_catalog_repository.dart';

class GetMovieByIdUsecase
    implements UseCase<Either<String, MovieEntity>, String> {
  final MovieCatalogRepository repository;

  GetMovieByIdUsecase({required this.repository});

  @override
  Future<Either<String, MovieEntity>> call(String params) {
    return repository.getMovieById(params);
  }
}
