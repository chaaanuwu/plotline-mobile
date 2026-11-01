import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/movie_poster/poster_card.dart';
import 'package:plotline_mobile/common/widgets/review_comment_sheet/review_comment_sheet.dart';
import 'package:plotline_mobile/core/configs/assets/app_images.dart';
import 'package:plotline_mobile/core/configs/urls/image_config.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/genre_chip.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_action.dart';
import 'package:plotline_mobile/features/reviews/presentation/widgets/review_options.dart';

class ReviewItem extends StatefulWidget {
  final dynamic reviewData;

  const ReviewItem({super.key, required this.reviewData});

  @override
  State<ReviewItem> createState() => ReviewItemState();
}

class ReviewItemState extends State<ReviewItem> {
  bool _isLiked = false;
  bool _isSaved = false;
  int _likeCount = 0;
  final int _commentCount = 0;

  @override
  Widget build(BuildContext context) {
    final reviewData = widget.reviewData;
    final user = reviewData.user;
    final movie = reviewData.movie;

    final isDark = context.isDarkMode;

    final backgroundColor = context.theme.scaffoldBackgroundColor;

    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.07);

    final textColor = isDark ? Colors.white : Colors.black;

    final secondaryTextColor = isDark
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
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(reviewData.createdAt),
                        style: TextStyle(
                          fontSize: 11,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showOptions(context),
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: secondaryTextColor,
                  ),
                  tooltip: 'More options',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // Movie preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 154,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (movie.backdropPath != null &&
                        movie.backdropPath.isNotEmpty)
                      Image.network(
                        '${ImageConfig.tmdbBackdropBaseUrl}${movie.backdropPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Image.asset(
                          AppImages.plotlineCover,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Image.asset(AppImages.plotlineCover, fit: BoxFit.cover),

                    // Overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withValues(alpha: 0.25),
                            backgroundColor.withValues(alpha: 0.78),
                            backgroundColor.withValues(alpha: 0.97),
                          ],
                          stops: const [0.0, 0.55, 1.0],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 88,
                            height: 130,
                            child: PosterCard(
                              posterPath:
                                  movie.posterPath == null ||
                                      movie.posterPath.isEmpty
                                  ? AppImages.popcornCup
                                  : '${ImageConfig.tmdbPosterBaseUrl}${movie.posterPath}',
                              height: 130,
                              spacing: 0,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                    color: Colors.white,
                                  ),
                                ),
                                if (releaseYear.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    releaseYear,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                    ),
                                  ),
                                ],
                                if (movie.genres.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: movie.genres
                                        .take(3)
                                        .map<Widget>(
                                          (genre) => GenreChip(label: genre),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Review content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Text(
              reviewData.reviewDescription,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.65,
                color: textColor.withValues(alpha: 0.87),
              ),
            ),
          ),

          // Divider
          Divider(height: 1, thickness: 1, color: borderColor),

          // Social actions
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
            child: Row(
              children: [
                Expanded(
                  child: ReviewAction(
                    icon: _isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: _likeCount == 0 ? 'Like' : '$_likeCount',
                    isActive: _isLiked,
                    activeColor: const Color(0xFFEF476F),
                    onTap: () {
                      setState(() {
                        _isLiked = !_isLiked;
                        _likeCount += _isLiked ? 1 : -1;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ReviewAction(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: _commentCount == 0 ? 'Comment' : '$_commentCount',
                    onTap: () => _showCommentSheet(context),
                  ),
                ),
                Expanded(
                  child: ReviewAction(
                    icon: _isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    label: _isSaved ? 'Saved' : 'Save',
                    isActive: _isSaved,
                    activeColor: const Color(0xFFF59E0B),
                    onTap: () {
                      setState(() => _isSaved = !_isSaved);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic value) {
    if (value == null) return '';

    final date = DateTime.tryParse(value.toString());
    if (date == null) return value.toString().split(' ').first;

    final difference = DateTime.now().difference(date);

    if (difference.isNegative) {
      return '${date.day}/${date.month}/${date.year}';
    }
    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }
    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }
    if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  void _showOptions(BuildContext context) {
    ReviewOptionsSheet.show(
      context: context,
      onShare: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review sharing will be added soon.')),
        );
      },
      onReport: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review reporting will be added soon.')),
        );
      },
    );
  }

  void _showCommentSheet(BuildContext context) {
    ReviewCommentSheet.show(
      context: context,
      onSubmit: (comment) {
        // TODO: Call comment cubit here.
        debugPrint('Comment: $comment');
      },
    );
  }
}
