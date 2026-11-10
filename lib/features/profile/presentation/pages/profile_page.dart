import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/profile_state.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:plotline_mobile/features/profile/presentation/widgets/profile_view.dart';
import 'package:plotline_mobile/service_locator.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;

  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return ProfileView(state: state, isOwnProfile: true);
        },
      );
    }

    return BlocProvider(
      create: (_) => sl<UserProfileCubit>()..loadUserProfile(userId!),
      child: BlocBuilder<UserProfileCubit, ProfileState>(
        builder: (context, state) {
          return ProfileView(state: state, isOwnProfile: false);
        },
      ),
    );
  }
}
