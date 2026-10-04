import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';

class RemoveSavedAuth implements UseCase<Either<String, void>, NoParams> {
  final AuthRepository repository;

  RemoveSavedAuth(this.repository);

  @override
  Future<Either<String, void>> call(NoParams params) {
    return repository.removeSavedAuth();
  }
}
