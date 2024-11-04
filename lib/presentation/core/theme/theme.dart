import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;
  final Color primaryColor = const Color(0xFFFF0000);
  final Color accentColor = const Color(0xFFFFADAD);
  final Color darkIcons = const Color(0xFF1E1E1E);
  final Color lightBackgroundColor = const Color.fromARGB(255, 242, 244, 247);
  final Color darkBackgroundColor = const Color.fromARGB(255, 33, 33, 33);

  AppTheme({this.isDarkMode = false});

  ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(primaryColor.value, const {
          50: Color(0xFFFFEBEE),
          100: Color(0xFFFFCDD2),
          200: Color(0xFFEF9A9A),
          300: Color(0xFFE57373),
          400: Color(0xFFEF5350),
          500: Color(0xFFF44336),
          600: Color(0xFFE53935),
          700: Color(0xFFD32F2F),
          800: Color(0xFFC62828),
          900: Color(0xFFB71C1C),
        }),
        accentColor: accentColor,
        errorColor: Colors.red,
        backgroundColor:  isDarkMode ? darkBackgroundColor : lightBackgroundColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      fontFamily: 'Roboto',

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : darkIcons, size: 24),
        ),
      
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
