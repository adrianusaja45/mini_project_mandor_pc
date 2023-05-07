import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.bodyColor,
  hintColor: AppColor.textColor,
  primaryColorLight: AppColor.buttonBackgroundColor,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColor.textColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: AppColor.textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: AppColor.textColorDark,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme(
    background: AppColor.bodyColor,
    primary: const Color(0xFF0415f7),
    secondary: const Color(0xFF0415f7),
    surface: AppColor.buttonBackgroundColorDark,
    onBackground: AppColor.textColor,
    onPrimary: AppColor.textColorDark,
    onSecondary: AppColor.textColor,
    onSurface: AppColor.textColor,
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.white,
  ).copyWith(error: Colors.red),
);
