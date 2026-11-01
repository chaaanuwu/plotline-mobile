import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:plotline_mobile/features/profile/presentation/widgets/profile_tabs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = context.watch<ProfileCubit>().state;

    final firstName = profileData?.user.firstName ?? '';
    final lastName = profileData?.user.lastName ?? '';
    final avatar = profileData?.user.avatarUrl;
    final cover = profileData?.user.coverUrl;
    final about = profileData?.user.about ?? '';
    final createdAt = profileData?.user.createdAt ?? '';

    final followersCount = profileData?.followersCount ?? 0;
    final followingCount = profileData?.followingCount ?? 0;

    final date = createdAt.isNotEmpty ? DateTime.tryParse(createdAt) : null;

    final joinedDate = date != null ? DateFormat('MMMM yyyy').format(date) : '';

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Profile header
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover and avatar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: cover == null || cover.isEmpty
                          ? Image.asset(
                              AppImages.plotlineCover,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '${ImageConfig.tmdbBackdropBaseUrl}$cover',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppImages.plotlineCover,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                    ),

                    // Cover gradient
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              context.isDarkMode
                                  ? AppColors.darkBackground
                                  : AppColors.lightBackground,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Avatar
                    Positioned(
                      bottom: -55,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: context.theme.scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: avatar == null || avatar.isEmpty
                              ? const AssetImage(AppImages.defaultpfp)
                              : NetworkImage(avatar),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Name and profile information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$firstName $lastName'.trim(),
                        style: context.theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      // Joined date
                      if (joinedDate.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.secondary
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.theme.colorScheme.secondary
                                  .withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            'Since $joinedDate',
                            style: context.theme.textTheme.labelSmall?.copyWith(
                              color: context.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],

                      // About
                      if (about.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        Text(
                          about,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Followers and following
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _ProfileStat(value: followersCount, label: 'FOLLOWERS'),
                        const _StatDivider(),
                        _ProfileStat(value: followingCount, label: 'FOLLOWING'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),

          ProfileTabs(scrollController: _scrollController),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final int value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value.toString(),
            style: context.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: context.theme.textTheme.bodySmall?.copyWith(
              color: context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: context.theme.dividerColor);
  }
}
