import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String text;
  final IconData? preIcon;
  final Color? iconColor;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  const Pill({
    super.key,
    required this.text,
    this.preIcon,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.borderRadius,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (preIcon != null) ...[
            Icon(preIcon!, color: iconColor, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
