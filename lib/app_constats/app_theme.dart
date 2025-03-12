import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFDCC38B),
      secondary: const Color(0xFFFFE488),
      surface: Colors.white,
      background: Colors.white,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Color(0xFFDCC38B), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFE488),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF6750A4),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );
}
