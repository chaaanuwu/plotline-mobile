abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SigninSuccess extends AuthState {
  final dynamic data;

  SigninSuccess(this.data);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
