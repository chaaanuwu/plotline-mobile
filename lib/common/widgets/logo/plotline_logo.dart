import 'package:flutter/material.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class PlotlineLogo extends StatelessWidget {
  final double fontSize;
  final bool overrideLogoTheme;

  const PlotlineLogo({
    super.key,
    this.fontSize = 40,
    this.overrideLogoTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'system-ui',
          fontWeight: FontWeight.w900,
          fontSize: fontSize,
          letterSpacing: -2,
        ),
        children: [
          TextSpan(
            text: 'PLOT',
            style: TextStyle(
              color: overrideLogoTheme
                  ? Colors.white
                  : context.isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          TextSpan(
            text: 'LINE',
            style: TextStyle(color: context.theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
