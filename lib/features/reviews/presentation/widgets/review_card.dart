import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_cubit.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReviewCubit>().state;

    if (state is ReviewInitial || state is ReviewLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is ReviewError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(state.message, textAlign: TextAlign.center),
        ),
      );
    }

    if (state is! ReviewLoaded) {
      return const SizedBox.shrink();
    }

    final reviews = state.reviews;

    if (reviews.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No reviews yet.'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final reviewData = reviews[index];

        return _ReviewItem(reviewData: reviewData);
      },
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final dynamic reviewData;

  const _ReviewItem({required this.reviewData});

  @override
  Widget build(BuildContext context) {
    final user = reviewData.user;
    final movie = reviewData.movie;

    final backgroundColor = context.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final borderColor = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    final secondaryTextColor = context.isDarkMode
        ? Colors.white.withValues(alpha: 0.55)
        : Colors.black.withValues(alpha: 0.55);

    final releaseDate = movie.releaseDate;
    final releaseYear = releaseDate.isNotEmpty
        ? releaseDate.split('-').first
        : '';

    final fullName = [user.firstName, user.lastName]
        .where((name) => name != null && name.toString().trim().isNotEmpty)
        .join(' ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer
          Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundImage:
                    user.avatar != null && user.avatar!.toString().isNotEmpty
                    ? NetworkImage(user.avatar!)
                    : const AssetImage(AppImages.defaultpfp) as ImageProvider,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName.isNotEmpty ? fullName : 'Unknown user',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),

                    Text(
                      reviewData.createdAt.toString().split(' ').first,
                      style: TextStyle(fontSize: 11, color: secondaryTextColor),
                    ),
                  ],
                ),
              ),

              Icon(Icons.more_vert, size: 20, color: secondaryTextColor),
            ],
          ),

          const SizedBox(height: 16),

          // Movie section
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // Background
                  Positioned.fill(
                    child:
                        movie.backdropPath == null || movie.backdropPath.isEmpty
                        ? Image.asset(
                            AppImages.plotlineCover,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${ImageConfig.tmdbBackdropBaseUrl}${movie.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                  ),

                  // Gradient
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          stops: const [0.0, 0.75, 1.0],
                          colors: [
                            context.isDarkMode
                                ? Colors.black.withValues(alpha: 0.15)
                                : Colors.white.withValues(alpha: 0.05),
                            context.isDarkMode
                                ? AppColors.darkBackground.withValues(
                                    alpha: 0.9,
                                  )
                                : AppColors.lightBackground.withValues(
                                    alpha: 0.85,
                                  ),
                            backgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Movie information
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 88,
                            height: 126,
                            child: PosterCard(
                              posterPath:
                                  movie.posterPath == null ||
                                      movie.posterPath.isEmpty
                                  ? AppImages.popcornCup
                                  : '${ImageConfig.tmdbPosterBaseUrl}${movie.posterPath}',
                              height: 126,
                              spacing: 0,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: context
                                        .theme
                                        .textTheme
                                        .titleMedium
                                        ?.fontSize,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    if (releaseYear.isNotEmpty)
                                      Text(
                                        releaseYear,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: secondaryTextColor,
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: movie.genres
                                      .map<Widget>(
                                        (genre) => _GenreChip(label: genre),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            reviewData.reviewDescription,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;

  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: context.isDarkMode
              ? Colors.white.withValues(alpha: 0.75)
              : Colors.black.withValues(alpha: 0.65),
        ),
      ),
    );
  }
}
