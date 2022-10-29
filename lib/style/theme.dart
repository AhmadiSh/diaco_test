import 'package:diaco_test/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  BuildContext context;

  MyTheme(this.context);

  static final lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.white,
      colorScheme: const ColorScheme(
        onPrimary: AppColors.white,
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        secondary: Colors.yellow,
        onSecondary: AppColors.gray900,
        error: Colors.red,
        onError: AppColors.white,
        background: AppColors.white,
        onBackground: AppColors.gray700, surface: AppColors.white, onSurface: AppColors.gray400,
      ),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        buttonColor: AppColors.primaryColor,
      ),
      iconTheme: const IconThemeData(color: AppColors.iconColor, opacity: 100),
      textTheme: TextTheme(
          headline3: const TextStyle(color: AppColors.gray700),
          headline4: const TextStyle(color: AppColors.gray700),
          headline5: const TextStyle(color: AppColors.gray700),
          headline6: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray700),
              fontWeight: FontWeight.w700),
          bodyText1: GoogleFonts.poppins(
              textStyle:
              const TextStyle(color: AppColors.gray700),
              fontWeight: FontWeight.w500),
          bodyText2: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray700),
              fontWeight: FontWeight.w500),
          subtitle1: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray700),
              fontWeight: FontWeight.w600),
          subtitle2: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray700),
              fontWeight: FontWeight.w600),
          overline: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray700)),
          caption: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray500),
              fontWeight: FontWeight.w400),
          button: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.white),
              fontWeight: FontWeight.w500))
  );

  static final darkTheme = ThemeData(primaryColor: AppColors.primaryColor);
}
