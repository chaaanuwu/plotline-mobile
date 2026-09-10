import 'package:flutter/material.dart';

extension DarkMode on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
