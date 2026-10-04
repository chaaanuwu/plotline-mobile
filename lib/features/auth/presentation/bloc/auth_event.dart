import 'package:plotline_mobile/features/auth/domain/usecases/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signup_user_req.dart';

abstract class AuthEvent {}

class SigninSubmitted extends AuthEvent {
  final SigninUserReq signinUserReq;

  SigninSubmitted({required this.signinUserReq});
}

class SignupSubmitted extends AuthEvent {
  final SignupUserReq signupUserReq;

  SignupSubmitted({required this.signupUserReq});
}
