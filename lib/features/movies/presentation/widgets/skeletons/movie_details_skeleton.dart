import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';

class MovieDetailsSkeleton extends StatefulWidget {
  const MovieDetailsSkeleton({super.key});

  @override
  State<MovieDetailsSkeleton> createState() => _MovieDetailsSkeletonState();
}

class _MovieDetailsSkeletonState extends State<MovieDetailsSkeleton>
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

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final skeletonColor = context.theme.colorScheme.onSurface.withValues(
      alpha: isDark ? 0.09 : 0.07,
    );

    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final backdropHeight = screenHeight * 0.42;
    final posterWidth = screenWidth * 0.42;
    final posterHeight = posterWidth * 1.5;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: FadeTransition(
        opacity: _controller,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Backdrop and poster
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: backdropHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Backdrop placeholder
                        Container(color: skeletonColor),

                        // Bottom gradient
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.45, 1.0],
                              colors: [
                                Colors.transparent,
                                backgroundColor.withValues(alpha: 0.75),
                                backgroundColor,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Poster placeholder
                  Padding(
                    padding: EdgeInsets.only(
                      top: backdropHeight - posterHeight * 0.9,
                    ),
                    child: Center(
                      child: _SkeletonBox(
                        width: posterWidth,
                        height: posterHeight,
                        color: skeletonColor,
                        radius: 12,
                      ),
                    ),
                  ),
                ],
              ),

              // Movie details content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 18),

                    // Movie title
                    _SkeletonBox(
                      width: screenWidth * 0.65,
                      height: 48,
                      color: skeletonColor,
                      radius: 6,
                    ),

                    const SizedBox(height: 12),

                    // Genres
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _SkeletonBox(
                          width: 65,
                          height: 26,
                          color: skeletonColor,
                          radius: 50,
                        ),
                        _SkeletonBox(
                          width: 75,
                          height: 26,
                          color: skeletonColor,
                          radius: 50,
                        ),
                        _SkeletonBox(
                          width: 55,
                          height: 26,
                          color: skeletonColor,
                          radius: 50,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Metadata row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SkeletonBox(
                          width: 38,
                          height: 15,
                          color: skeletonColor,
                        ),
                        const SizedBox(width: 16),
                        _SkeletonBox(
                          width: 55,
                          height: 15,
                          color: skeletonColor,
                        ),
                        const SizedBox(width: 16),
                        _SkeletonBox(
                          width: 38,
                          height: 15,
                          color: skeletonColor,
                        ),
                        const SizedBox(width: 12),
                        _SkeletonBox(
                          width: 16,
                          height: 16,
                          color: skeletonColor,
                          radius: 4,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Release status
                    _SkeletonBox(width: 85, height: 15, color: skeletonColor),

                    const SizedBox(height: 12),

                    // Watched and watchlist buttons
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _SkeletonBox(
                            width: double.infinity,
                            height: 52,
                            color: skeletonColor,
                            radius: 10,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _SkeletonBox(
                            width: double.infinity,
                            height: 52,
                            color: skeletonColor,
                            radius: 10,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Write a review button
                    _SkeletonBox(
                      width: double.infinity,
                      height: 52,
                      color: skeletonColor,
                      radius: 10,
                    ),

                    const SizedBox(height: 32),

                    // Overview section
                    _buildSectionHeading(width: 105, color: skeletonColor),

                    const SizedBox(height: 14),

                    _SkeletonBox(
                      width: double.infinity,
                      height: 14,
                      color: skeletonColor,
                    ),

                    const SizedBox(height: 9),

                    _SkeletonBox(
                      width: double.infinity,
                      height: 14,
                      color: skeletonColor,
                    ),

                    const SizedBox(height: 9),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: _SkeletonBox(
                        width: screenWidth * 0.65,
                        height: 14,
                        color: skeletonColor,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Community reviews section
                    _buildSectionHeading(width: 185, color: skeletonColor),

                    const SizedBox(height: 14),

                    // Community reviews card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: skeletonColor),
                      ),
                      child: Column(
                        children: [
                          // Icon placeholder
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: skeletonColor,
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Card title
                          _SkeletonBox(
                            width: 190,
                            height: 17,
                            color: skeletonColor,
                          ),

                          const SizedBox(height: 10),

                          // Card description
                          _SkeletonBox(
                            width: double.infinity,
                            height: 12,
                            color: skeletonColor,
                          ),

                          const SizedBox(height: 7),

                          _SkeletonBox(
                            width: screenWidth * 0.55,
                            height: 12,
                            color: skeletonColor,
                          ),

                          const SizedBox(height: 16),

                          // See reviews button
                          _SkeletonBox(
                            width: double.infinity,
                            height: 43,
                            color: skeletonColor,
                            radius: 12,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeading({required double width, required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          _SkeletonBox(width: 3, height: 20, color: color, radius: 4),
          const SizedBox(width: 10),
          _SkeletonBox(width: width, height: 20, color: color),
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
