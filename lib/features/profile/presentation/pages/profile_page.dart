import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/features/profile/presentation/bloc/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileData = context.watch<ProfileCubit>().state;

    final avatar = profileData?.user.avatarUrl;
    final cover = profileData?.user.coverUrl;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: cover == null || cover.isEmpty
                    ? Image.asset(AppImages.plotlineCover, fit: BoxFit.cover)
                    : Image.network(cover, fit: BoxFit.cover),
              ),

              Positioned(
                bottom: -75,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: avatar == null || avatar.isEmpty
                        ? const AssetImage(AppImages.defaultpfp)
                        : NetworkImage(avatar),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 90),

          Text(
            '${profileData?.user.firstName ?? ''} '
            '${profileData?.user.lastName ?? ''}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
