import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marshmallow/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );
}
