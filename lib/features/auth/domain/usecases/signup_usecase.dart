import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signup_user_req.dart';

class SignupUsecase implements UseCase<Either<String, AuthEntity>, SignupUserReq> {
  final AuthRepository repository;

  const SignupUsecase(this.repository);

  @override
  Future<Either<String, AuthEntity>> call(SignupUserReq params) {
    return repository.signup(params);
  }
}
