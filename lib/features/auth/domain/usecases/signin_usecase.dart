import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signin_user_req.dart';

class SigninUsecase
    implements UseCase<Either<String, AuthEntity>, SigninUserReq> {
  final AuthRepository repository;

  const SigninUsecase(this.repository);

  @override
  Future<Either<String, AuthEntity>> call(SigninUserReq params) {
    return repository.signin(params);
  }
}
