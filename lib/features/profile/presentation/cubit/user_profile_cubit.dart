import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/profile/domain/usecase/get_user_profile_usecase.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/profile_state.dart';

class UserProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;

  UserProfileCubit({required this.getUserProfileUsecase})
    : super(ProfileInitial());

  Future<void> loadUserProfile(String userId) async {
    emit(ProfileLoading());

    try {
      final result = await getUserProfileUsecase(
        GetUserProfileParams(userId: userId),
      );

      result.fold(
        (error) {
          debugPrint('USER PROFILE ERROR: $error');
          emit(ProfileError(message: error));
        },
        (profile) {
          if (profile == null) {
            emit(ProfileError(message: 'User profile not found'));
            return;
          }

          debugPrint('USER PROFILE LOADED SUCCESSFULLY');
          emit(ProfileLoaded(profile: profile));
        },
      );
    } catch (e, stackTrace) {
      debugPrint('USER PROFILE EXCEPTION: $e');
      debugPrintStack(stackTrace: stackTrace);

      emit(ProfileError(message: e.toString()));
    }
  }
}
