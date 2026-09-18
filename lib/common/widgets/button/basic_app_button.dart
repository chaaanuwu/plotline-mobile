import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size.fromHeight(height ?? 80),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      child: Text(title),
    );
  }
}
