import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class ReviewOptionsSheet extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onReport;

  const ReviewOptionsSheet({
    super.key,
    required this.onShare,
    required this.onReport,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onShare,
    required VoidCallback onReport,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.isDarkMode
          ? const Color(0xFF181818)
          : Colors.white,
      builder: (_) => ReviewOptionsSheet(onShare: onShare, onReport: onReport),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final iconColor = isDark ? Colors.white70 : Colors.black54;
    final textColor = isDark ? Colors.white : Colors.black87;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.share_outlined, color: iconColor),
            title: Text('Share review', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
              onShare();
            },
          ),
          ListTile(
            leading: Icon(Icons.flag_outlined, color: iconColor),
            title: Text('Report review', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
              onReport();
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
