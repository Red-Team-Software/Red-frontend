import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;
  final Color primaryColor = const Color(0xFFFF0000);
  final Color accentColor = const Color(0xFFFFADAD);
  final Color darkIcons = const Color(0xFF1E1E1E);
  final Color lightBackgroundColor = const Color(0xFFF2F4F7);
  final Color darkBackgroundColor = const Color(0xFF1E1E1E);

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
        backgroundColor:
            isDarkMode ? darkBackgroundColor : lightBackgroundColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor: isDarkMode? darkBackgroundColor: lightBackgroundColor,
      fontFamily: 'Catamaran',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: isDarkMode ? Colors.white : darkIcons,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(
            color: isDarkMode ? Colors.white : darkIcons, size: 24),
      ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light, 
    );
  }
}
