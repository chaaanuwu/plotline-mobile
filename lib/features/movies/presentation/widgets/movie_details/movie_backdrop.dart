import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';

class MovieBackdrop extends StatelessWidget {
  final MovieEntity movie;
  final double height;

  const MovieBackdrop({super.key, required this.movie, required this.height});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Backdrop image
          movie.backdropPath.isEmpty
              ? Image.asset(AppImages.plotlineCover, fit: BoxFit.cover)
              : Image.network(
                  '${ImageConfig.tmdbBackdropBaseUrl}${movie.backdropPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.plotlineCover,
                      fit: BoxFit.cover,
                    );
                  },
                ),

          // Gradient
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.45, 1.0],
                colors: [
                  Colors.transparent,
                  (isDark
                          ? AppColors.darkBackground
                          : AppColors.lightBackground)
                      .withValues(alpha: 0.75),
                  isDark ? AppColors.darkBackground : AppColors.lightBackground,
                ],
              ),
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.paddingOf(context).top + 24,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  LucideIcons.arrowLeft,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
