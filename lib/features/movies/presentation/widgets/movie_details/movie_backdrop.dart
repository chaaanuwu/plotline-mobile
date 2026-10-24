import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/widgets/movie_details/profile_cover_bottom_sheet.dart';

class MovieBackdrop extends StatelessWidget {
  final MovieEntity movie;
  final double height;
  final VoidCallback setAsProfileCover;

  const MovieBackdrop({
    super.key,
    required this.movie,
    required this.height,
    required this.setAsProfileCover,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final topInset = MediaQuery.paddingOf(context).top + 24;

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

          // Bottom gradient
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
            top: topInset,
            left: 16,
            child: _BackdropActionButton(
              icon: LucideIcons.arrowLeft,
              tooltip: 'Go back',
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ),

          // Open the profile-cover confirmation sheet
          Positioned(
            top: topInset,
            right: 16,
            child: _BackdropActionButton(
              icon: LucideIcons.image,
              tooltip: 'Set as profile cover',
              onTap: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => BlocProvider.value(
                  value: context.read<MovieDetailsCubit>(),
                  child: ProfileCoverBottomSheet(
                    movie: movie,
                    onConfirm: () {
                      setAsProfileCover();
                    },
                  ),
                ),
              ),
              iconColor: const Color(0xFFF59E0B),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackdropActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final Color iconColor;

  const _BackdropActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.black.withValues(alpha: 0.50),
        shape: CircleBorder(
          side: BorderSide(color: Colors.white.withValues(alpha: 0.18)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(icon, color: iconColor, size: 21),
          ),
        ),
      ),
    );
  }
}
