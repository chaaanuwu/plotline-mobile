import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/get_saved_auth.dart';

class ProfileCubit extends Cubit<AuthEntity?> {
  final GetSavedAuth getSavedAuth;

  ProfileCubit({required this.getSavedAuth}) : super(null);

  Future<void> loadProfile() async {
    final result = await getSavedAuth(NoParams());

    result.fold(
      (error) {
        emit(null);
      },
      (auth) {
        emit(auth);
      },
    );
  }
}
