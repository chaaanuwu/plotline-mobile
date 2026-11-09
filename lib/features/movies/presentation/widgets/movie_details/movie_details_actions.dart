import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';
import 'package:plotline_mobile/core/configs/theme/app_colors.dart';

class MovieDetailsActions extends StatelessWidget {
  final VoidCallback? onMarkWatched;
  final VoidCallback? onToggleWatchlist;
  final VoidCallback? onWriteReview;

  // History
  final bool isInHistory;
  final bool isHistoryLoading;

  // Watchlist
  final bool isInWatchlist;
  final bool isWatchlistLoading;

  const MovieDetailsActions({
    super.key,
    this.onMarkWatched,
    this.onToggleWatchlist,
    this.onWriteReview,
    this.isInHistory = false,
    this.isHistoryLoading = true,
    this.isInWatchlist = false,
    this.isWatchlistLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.theme.colorScheme.primary;
    final secondaryColor = context.theme.colorScheme.secondary;

    return Column(
      children: [
        Row(
          children: [
            // Mark as Watched
            Expanded(
              flex: 3,
              child: Tooltip(
                message: isHistoryLoading
                    ? 'Checking history...'
                    : isInHistory
                    ? 'Already Watched'
                    : 'Mark as Watched',
                child: BasicAppButton(
                  onPressed: () {},
                  height: 52,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  title: isHistoryLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.circleCheckBig, size: 22),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                isInHistory ? 'Watched' : 'Mark as Watched',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Watchlist
            Expanded(
              flex: 1,
              child: Tooltip(
                message: isWatchlistLoading
                    ? 'Checking watchlist...'
                    : isInWatchlist
                    ? 'Remove from Watchlist'
                    : 'Add to Watchlist',
                child: BasicAppButton(
                  onPressed: () {},
                  height: 52,
                  backgroundColor: AppColors.accentColor.withValues(
                    alpha: 0.15,
                  ),
                  textColor: isInWatchlist
                      ? Colors.white
                      : AppColors.accentColor,
                  borderColor: AppColors.accentColor.withValues(alpha: 1.0),
                  title: isWatchlistLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.accentColor,
                          ),
                        )
                      : Icon(
                          isInWatchlist ? Icons.bookmark : LucideIcons.bookmark,
                          size: 23,
                          color: AppColors.accentColor,
                        ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Write a Review
        SizedBox(
          width: double.infinity,
          child: BasicAppButton(
            onPressed: () {},
            height: 52,
            backgroundColor: secondaryColor.withValues(alpha: 0.15),
            textColor: secondaryColor,
            borderColor: secondaryColor.withValues(alpha: 0.4),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.messagesSquare, size: 22),
                SizedBox(width: 8),
                Text(
                  'Write a Review',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
