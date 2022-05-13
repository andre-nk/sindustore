// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static AppColors colors = AppColors();
  static AppTypography text = AppTypography();
  static DefaultAppTheme defaultTheme = DefaultAppTheme();
}

class AppColors {
  Color primary = const Color(0xFF1A2C50);
  Color secondary = const Color(0xFFFFBE00);
  Color tertiary = const Color(0xFF118EEA);
  Color error = const Color(0xFFFF6B6B);
  Color warning = const Color(0xFFF2C46F);
  Color success = const Color(0xFF04AA0E);
  Color background = const Color(0xFFFFFFFF);
  Color surface = const Color(0xFFF4F4F4);
  Color outline = const Color(0x808F98AA);
}

class AppTypography {
  TextStyle h1 = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.w600, fontSize: 32);
  TextStyle h2 = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.w600, fontSize: 28);
  TextStyle h3 = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.w500, fontSize: 22);
  TextStyle title = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.w600, fontSize: 20);
  TextStyle paragraph = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.normal, fontSize: 18);
  TextStyle subtitle = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.normal, fontSize: 16);
  TextStyle footnote = const TextStyle(
      color: Color(0xFF333333), fontWeight: FontWeight.w300, fontSize: 14);
}

class DefaultAppTheme {
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
      scaffoldBackgroundColor: AppColors().background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors().primary,
        contentTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        actionTextColor: AppColors().secondary,
      ),
    );
  }
}
