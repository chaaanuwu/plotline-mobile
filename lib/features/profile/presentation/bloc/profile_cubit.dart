import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';
import 'package:plotline_mobile/features/profile/domain/usecase/get_me_use_case.dart';

class ProfileCubit extends Cubit<ProfileEntity?> {
  final GetMeUseCase getMeUseCase;

  ProfileCubit({required this.getMeUseCase}) : super(null);

  Future<void> loadProfile() async {
    print('PROFILE: loadProfile() called');

    final result = await getMeUseCase(NoParams());

    print('PROFILE: GetMeUseCase completed');

    result.fold(
  (error) {
    print('PROFILE ERROR: $error');
    emit(null);
  },
  (profile) {
    print('PROFILE SUCCESS: $profile');
    print('PROFILE USER: ${profile?.user.firstName}');
    print('PROFILE AVATAR: ${profile?.user.avatarUrl}');
    print('PROFILE FOLLOWERS: ${profile?.followersCount}');

    emit(profile);
  },
);
  }
}