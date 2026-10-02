import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/service_locator.dart';

class SignupUsecase implements UseCase<Either, SignupUserReq> {
  @override
  Future<Either<dynamic, dynamic>> call(SignupUserReq params) {
    return sl<AuthRepository>().signup(params);
  }
}
