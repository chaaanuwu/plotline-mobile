import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class AuthPrompt extends StatelessWidget {
  final String prompt;
  final String actionText;
  final VoidCallback onPressed;

  const AuthPrompt({
    super.key,
    required this.prompt,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              prompt,
              style: TextStyle(
                fontSize: 14,
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                actionText,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
