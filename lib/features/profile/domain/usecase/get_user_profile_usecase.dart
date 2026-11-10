import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';
import 'package:plotline_mobile/features/profile/domain/repository/profile_repository.dart';

class GetUserProfileUsecase
    implements UseCase<Either<String, ProfileEntity?>, GetUserProfileParams> {
  final ProfileRepository repository;

  GetUserProfileUsecase({required this.repository});

  @override
  Future<Either<String, ProfileEntity?>> call(GetUserProfileParams params) {
    return repository.getUserProfile(params.userId);
  }
}

class GetUserProfileParams {
  final String userId;

  const GetUserProfileParams({required this.userId});
}
