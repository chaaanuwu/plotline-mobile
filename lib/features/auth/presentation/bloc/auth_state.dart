import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SigninSuccess extends AuthState {
  final AuthEntity auth;

  SigninSuccess(this.auth);
}

class SignupSuccess extends AuthState {
  final AuthEntity auth;

  SignupSuccess(this.auth);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
