import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/profile/presentation/cubit/profile_state.dart';
import 'package:plotline_mobile/features/profile/presentation/widgets/profile_header_skeleton.dart';
import 'package:plotline_mobile/features/profile/presentation/widgets/profile_tabs.dart';

class ProfileView extends StatefulWidget {
  final ProfileState state;
  final bool isOwnProfile;

  const ProfileView({
    super.key,
    required this.state,
    this.isOwnProfile = false,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
    final state = widget.state;

    if (state is ProfileInitial || state is ProfileLoading) {
      return const Scaffold(body: ProfileHeaderSkeleton());
    }

    if (state is ProfileError) {
      return Scaffold(body: Center(child: Text(state.message)));
    }

    if (state is ProfileLoaded) {
      final profile = state.profile;

      final date = profile.user.createdAt.isNotEmpty
          ? DateTime.tryParse(profile.user.createdAt)
          : null;

      final joinedDate = date != null
          ? DateFormat('MMMM yyyy').format(date)
          : '';

      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
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
                        child: profile.user.coverUrl.isEmpty
                            ? Image.asset(
                                AppImages.plotlineCover,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${ImageConfig.tmdbBackdropBaseUrl}${profile.user.coverUrl}',
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
                            backgroundImage: profile.user.avatarUrl.isEmpty
                                ? const AssetImage(AppImages.defaultpfp)
                                : NetworkImage(profile.user.avatarUrl),
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
                          '${profile.user.firstName} ${profile.user.lastName}'
                              .trim(),
                          style: context.theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),

                        // Joined date
                        if (joinedDate.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
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
                                style: context.theme.textTheme.labelSmall
                                    ?.copyWith(
                                      color:
                                          context.theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                        ],

                        // Followers and following
                        Row(
                          children: [
                            _ProfileStat(
                              value: profile.followersCount,
                              label: 'followers',
                            ),
                            Container(
                              width: 1,
                              height: 22,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              color: context.theme.dividerColor.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            _ProfileStat(
                              value: profile.followingCount,
                              label: 'following',
                            ),
                          ],
                        ),

                        // About
                        if (profile.user.about.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          Text(
                            profile.user.about,
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ],

                        // Put profile-specific actions here.
                        // Edit Profile for own profile.
                        // Follow button for another user's profile.
                      ],
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

    return const Scaffold(body: SizedBox.shrink());
  }
}

class _ProfileStat extends StatelessWidget {
  final int value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          NumberFormat.compact().format(value),
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: context.theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
