import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/signin_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUsecase signinUsecase;

  AuthBloc(this.signinUsecase) : super(AuthInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
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
}
