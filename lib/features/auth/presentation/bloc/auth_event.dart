import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';

abstract class AuthEvent {}

class SigninSubmitted extends AuthEvent {
  final SigninUserReq signinUserReq;

  SigninSubmitted({required this.signinUserReq});
}
