import 'package:flutter/material.dart';
import 'package:plotline_mobile/core/configs/theme/app_theme.dart';
import 'package:plotline_mobile/features/splash/presentation/pages/splash_page.dart';

void main() {
  runApp(const Plotline());
}

class Plotline extends StatelessWidget {
  const Plotline({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
