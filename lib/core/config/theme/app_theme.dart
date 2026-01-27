import 'package:flutter/material.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Bitter',
    appBarTheme: AppBarThemeData(backgroundColor: AppColors.lightBackground),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Bitter',
    appBarTheme: AppBarThemeData(backgroundColor: AppColors.darkBackground),
  );
}
