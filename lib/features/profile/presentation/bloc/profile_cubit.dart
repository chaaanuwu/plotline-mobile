import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';
import 'package:plotline_mobile/features/profile/domain/usecase/get_me_use_case.dart';

class ProfileCubit extends Cubit<ProfileEntity?> {
  final GetMeUseCase getMeUseCase;

  ProfileCubit({required this.getMeUseCase}) : super(null);

  Future<void> loadProfile() async {
    final result = await getMeUseCase(NoParams());

    result.fold(
      (error) {
        emit(null);
      },
      (profile) {
        emit(profile);
      },
    );
  }
}