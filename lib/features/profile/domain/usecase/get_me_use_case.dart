import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';
import 'package:plotline_mobile/features/profile/domain/repository/profile_repository.dart';

class GetMeUseCase implements UseCase<Either<String, ProfileEntity?>, NoParams> {
  final ProfileRepository repository;

  GetMeUseCase({required this.repository});

  @override
  Future<Either<String, ProfileEntity?>> call(NoParams params) {
    return repository.getUserMeProfile();
  }
}
