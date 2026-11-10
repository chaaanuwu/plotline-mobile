import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/profile/domain/usecase/get_me_use_case.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase getMeUseCase;

  ProfileCubit({required this.getMeUseCase}) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    try {
      final result = await getMeUseCase(NoParams());

      result.fold(
        (error) {
          debugPrint('PROFILE ERROR: $error');
          emit(ProfileError(message: error));
        },
        (profile) {
          debugPrint('PROFILE LOADED SUCCESSFULLY');
          emit(ProfileLoaded(profile: profile!));
        },
      );
    } catch (e, stackTrace) {
      debugPrint('PROFILE EXCEPTION: $e');
      debugPrintStack(stackTrace: stackTrace);

      emit(ProfileError(message: e.toString()));
    }
  }
}
