import 'package:flutter/material.dart';

class AppTheme {
  //------------------> Light Theme <---------------------//
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF388E3C),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF388E3C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF388E3C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(
          fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
      displaySmall: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
      headlineSmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
      labelSmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.grey),
    ),
  );

  //------------------> Dark Theme <---------------------//
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF388E3C),
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF388E3C),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 57, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white70),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
      labelSmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white60),
    ),
  );
}
