import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange[100],
    backgroundColor: Colors.grey[700],
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1A202C),
    backgroundColor: Colors.white60,
  );
}
