import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/app_snackbar.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/movie_catalog/domain/entity/movie_entity.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:plotline_mobile/features/movies/presentation/cubit/movie_details/movie_details_state.dart';

class ProfileCoverBottomSheet extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback onConfirm;

  const ProfileCoverBottomSheet({
    super.key,
    required this.movie,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = context.isDarkMode ? Colors.white60 : Colors.black54;
    final primaryColor = context.theme.colorScheme.primary;

    return BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
      listener: (context, state) {
        if (state is! MovieDetailsLoaded) return;

        switch (state.profileCoverStatus) {
          case ProfileCoverStatus.success:
            AppSnackBar.showSuccess(
              context,
              'Profile cover updated successfully!',
            );

            Navigator.of(context).pop();
            break;

          case ProfileCoverStatus.error:
            AppSnackBar.showError(
              context,
              state.profileCoverError ?? 'Failed to update profile cover.',
            );
            break;

          case ProfileCoverStatus.initial:
          case ProfileCoverStatus.loading:
            break;
        }
      },
      builder: (context, state) {
        final isLoading =
            state is MovieDetailsLoaded &&
            state.profileCoverStatus == ProfileCoverStatus.loading;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? context.theme.colorScheme.surface
                : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: subtitleColor.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Title and subtitle
                  Text(
                    'Set Profile Cover',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Give your profile a new look with a profile cover. You can always change it later.',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Backdrop preview
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: subtitleColor.withValues(alpha: 0.15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 180,
                        child: movie.backdropPath.isEmpty
                            ? Image.asset(
                                AppImages.plotlineCover,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${ImageConfig.tmdbBackdropBaseUrl}'
                                '${movie.backdropPath}',
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) {
                                  return Image.asset(
                                    AppImages.plotlineCover,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Information
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LucideIcons.info, size: 17, color: subtitleColor),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'This movie backdrop will replace your current profile cover.',
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Confirm button
                  BasicAppButton(
                    onPressed: movie.backdropPath.isEmpty || isLoading
                        ? null
                        : onConfirm,
                    title: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Updating Cover...'),
                            ],
                          )
                        : const Text('Set As Profile Cover'),
                    backgroundColor: primaryColor,
                    height: 65,
                  ),

                  const SizedBox(height: 12),

                  // Cancel button
                  BasicAppButton(
                    onPressed: isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    title: const Text('Cancel'),
                    backgroundColor: Colors.transparent,
                    borderColor: context.theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.25),
                    textColor: textColor,
                    height: 65,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
