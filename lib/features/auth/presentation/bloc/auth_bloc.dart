import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signin_usecase.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signup_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signinUsecase;
  final SignupUsecase signupUsecase;

  AuthBloc({required this.signinUsecase, required this.signupUsecase})
    : super(AuthInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signinUsecase(event.signinUserReq);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (auth) => emit(SigninSuccess(auth)),
    );
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signupUsecase(event.signupUserReq);

    result.fold(
      (error) => emit(AuthFailure(error)),
      (auth) => emit(SignupSuccess(auth)),
    );
  }
}
