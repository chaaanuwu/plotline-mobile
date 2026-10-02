import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signin_usecase.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signup_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signinUsecase;
  final SignupUsecase signupUseCase;

  AuthBloc(this.signinUsecase, this.signupUseCase) : super(AuthInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signinUsecase(event.signinUserReq);

    print('SIGN IN RESULT: $result');

    result.fold(
      (error) {
        emit(AuthFailure(error.toString()));
      },
      (data) {
        emit(SigninSuccess(data));
      },
    );
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signupUseCase(event.signupUserReq);

    print('SIGN UP RESULT: $result');

    result.fold(
      (error) {
        emit(AuthFailure(error.toString()));
      },
      (data) {
        emit(SignupSuccess(data));
      },
    );
  }
}
