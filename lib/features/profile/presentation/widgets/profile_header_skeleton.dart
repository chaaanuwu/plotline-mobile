import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class ProfileHeaderSkeleton extends StatefulWidget {
  const ProfileHeaderSkeleton({super.key});

  @override
  State<ProfileHeaderSkeleton> createState() => _ProfileHeaderSkeletonState();
}

class _ProfileHeaderSkeletonState extends State<ProfileHeaderSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.4,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final skeletonColor = context.theme.colorScheme.onSurface.withValues(
      alpha: isDark ? 0.09 : 0.07,
    );

    return FadeTransition(
      opacity: _controller,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover and avatar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 240,
                      color: skeletonColor,
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
                          backgroundColor: skeletonColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Profile information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      _SkeletonBox(
                        width: 190,
                        height: 25,
                        color: skeletonColor,
                      ),

                      const SizedBox(height: 12),

                      // Joined date
                      _SkeletonBox(
                        width: 125,
                        height: 25,
                        radius: 20,
                        color: skeletonColor,
                      ),

                      const SizedBox(height: 14),

                      // Followers and following
                      Row(
                        children: [
                          _SkeletonBox(
                            width: 100,
                            height: 18,
                            color: skeletonColor,
                          ),
                          const SizedBox(width: 18),
                          Container(
                            width: 1,
                            height: 22,
                            color: context.theme.dividerColor.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(width: 18),
                          _SkeletonBox(
                            width: 100,
                            height: 18,
                            color: skeletonColor,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // About
                      _SkeletonBox(
                        width: double.infinity,
                        height: 13,
                        color: skeletonColor,
                      ),
                      const SizedBox(height: 8),
                      _SkeletonBox(
                        width: double.infinity,
                        height: 13,
                        color: skeletonColor,
                      ),
                      const SizedBox(height: 8),
                      _SkeletonBox(
                        width: 180,
                        height: 13,
                        color: skeletonColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color color;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.color,
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
