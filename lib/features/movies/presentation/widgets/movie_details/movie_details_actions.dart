import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';
import 'package:plotline_mobile/common/widgets/button/basic_app_button.dart';

class MovieDetailsActions extends StatelessWidget {
  final VoidCallback? onMarkWatched;
  final VoidCallback? onToggleWatchlist;
  final VoidCallback? onWriteReview;

  const MovieDetailsActions({
    super.key,
    this.onMarkWatched,
    this.onToggleWatchlist,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.theme.colorScheme.primary;
    final secondaryColor = context.theme.colorScheme.secondary;

    final secondaryBackground = secondaryColor.withValues(alpha: 0.15);
    final secondaryBorder = secondaryColor.withValues(alpha: 0.4);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: BasicAppButton(
                onPressed: onMarkWatched ?? () {},
                height: 52,
                backgroundColor: primaryColor,
                textColor: Colors.white,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.circleCheckBig, size: 22),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Mark as Watched',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              flex: 1,
              child: BasicAppButton(
                onPressed: onToggleWatchlist ?? () {},
                height: 52,
                backgroundColor: secondaryBackground,
                textColor: secondaryColor,
                borderColor: secondaryBorder,
                title: const Icon(LucideIcons.bookmark, size: 23),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: BasicAppButton(
            onPressed: onWriteReview ?? () {},
            height: 52,
            backgroundColor: secondaryBackground,
            textColor: secondaryColor,
            borderColor: secondaryBorder,
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
