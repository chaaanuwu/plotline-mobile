import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class CommunityReviewsSection extends StatelessWidget {
  final VoidCallback? onSeeReviewsTap;

  const CommunityReviewsSection({super.key, this.onSeeReviewsTap});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.black87;
    final primaryColor = context.theme.colorScheme.primary;
    final surfaceColor = context.theme.colorScheme.surface;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 20,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Community Reviews',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: textColor.withValues(alpha: 0.07)),
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.messagesSquare,
                    color: primaryColor,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'See What the Community Thinks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore reviews, ratings, and opinions from other movie lovers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onSeeReviewsTap,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(
                        color: primaryColor.withValues(alpha: 0.45),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'See Community Reviews',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(LucideIcons.arrowRight, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
