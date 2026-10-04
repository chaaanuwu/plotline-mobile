import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';

class GetSavedAuth implements UseCase<Either<String, AuthEntity?>, NoParams> {
  final AuthRepository repository;

  GetSavedAuth(this.repository);

  @override
  Future<Either<String, AuthEntity?>> call(NoParams params) {
    return repository.getSavedAuth();
  }
}
