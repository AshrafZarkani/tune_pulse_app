import 'package:flutter/material.dart';
import 'package:tune_pulse/app/core/constants/my_app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(color: MyColors.othersWhite),
            bodyLarge: const TextStyle(color: MyColors.othersWhite),
            bodySmall: const TextStyle(color: MyColors.othersWhite),
          ),
    ),
    primaryColor: MyColors.primary_500,
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColors.primary_500,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.primary_500,
      elevation: 0,
      iconTheme: IconThemeData(color: MyColors.primary_500),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: MyColors.secondary_500,
      disabledColor: MyColors.secondary_500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.secondary_500,
      ),
    ),
  );
}
