import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/service_locator.dart';

class SigninUsecase implements UseCase<Either, SigninUserReq> {
  @override
  Future<Either<dynamic, dynamic>> call(SigninUserReq params) {
    return sl<AuthRepository>().signin(params);
  }
}
