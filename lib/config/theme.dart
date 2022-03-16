import 'package:flutter/material.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: Color(0xFF1A2C50),
        onPrimary: Color(0xFF1A2C50),
        secondary: Color(0xFFFFBE00),
        onSecondary: Color(0xFFFFBE00),
        tertiary: Color(0xFF118EEA),
        onTertiary: Color(0xFF118EEA),
        error: Color(0xFFFF6B6B),
        onError: Color(0xFFFF6B6B),
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFFFFFFFF),
        surface: Color(0xFFF4F4F4),
        onSurface: Color(0xFFF4F4F4),
        outline: Color(0x808F98AA),
        brightness: Brightness.light,
      ),
      fontFamily: 'MaisonNeue',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w700,
          fontSize: 36
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w600,
          fontSize: 28
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w500,
          fontSize: 22
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.normal,
          fontSize: 18
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.normal,
          fontSize: 16
        ),
        bodySmall: TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.w300,
          fontSize: 14
        )
      )
    );
  }
}
