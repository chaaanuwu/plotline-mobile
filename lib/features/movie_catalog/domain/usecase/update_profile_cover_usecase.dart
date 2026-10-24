import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/repository/movie_catalog_repository.dart';

class UpdateProfileCoverUsecase
    implements UseCase<Either<String, Unit>, String> {
  final MovieCatalogRepository repository;

  UpdateProfileCoverUsecase({required this.repository});

  @override
  Future<Either<String, Unit>> call(String params) {
    return repository.updateProfileCover(params);
  }
}
