import 'package:plotline_mobile/features/auth/data/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/data/requests/signup_user_req.dart';

abstract class AuthEvent {}

class SigninSubmitted extends AuthEvent {
  final SigninUserReq signinUserReq;

  SigninSubmitted({required this.signinUserReq});
}

class SignupSubmitted extends AuthEvent {
  final SignupUserReq signupUserReq;

  SignupSubmitted({required this.signupUserReq});
}
