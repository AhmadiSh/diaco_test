import 'package:diaco_test/ui/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  BuildContext context;

  MyTheme(this.context);

  static final lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.white,
scaffoldBackgroundColor: AppColors.gray100,
cardColor: AppColors.white,
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

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.gray500,
      scaffoldBackgroundColor: AppColors.gray600,
      cardColor: AppColors.gray900,
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        buttonColor: AppColors.primaryColor,
      ),
      iconTheme: const IconThemeData(color: AppColors.gray50, opacity: 100),
      textTheme: TextTheme(
          headline3: const TextStyle(color: AppColors.white),
          headline4: const TextStyle(color: AppColors.white),
          headline5: const TextStyle(color: AppColors.white),
          headline6: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.white),
              fontWeight: FontWeight.w700),
          bodyText1: GoogleFonts.poppins(
              textStyle:
              const TextStyle(color: AppColors.gray100),
              fontWeight: FontWeight.w500),
          bodyText2: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray50),
              fontWeight: FontWeight.w500),
          subtitle1: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray50),
              fontWeight: FontWeight.w600),
          subtitle2: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray50),
              fontWeight: FontWeight.w600),
          overline: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray100)),
          caption: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.gray100),
              fontWeight: FontWeight.w400),
          button: GoogleFonts.poppins(
              textStyle:
              const TextStyle( color: AppColors.white),
              fontWeight: FontWeight.w500))
  );}
