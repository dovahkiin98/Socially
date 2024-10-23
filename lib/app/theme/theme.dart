import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: AppColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
  ),
  useMaterial3: false,
  // Use GoogleFonts to get the font
  textTheme: GoogleFonts.gloryTextTheme(),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
    ),
  )
);
