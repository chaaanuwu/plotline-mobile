import 'package:plotline_mobile/features/auth/data/models/signup_data.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SigninSuccess extends AuthState {
  final dynamic data;

  SigninSuccess(this.data);
}

class SignupInProgress extends AuthState {
  final SignupData data;

  SignupInProgress(this.data);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
