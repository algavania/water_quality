import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_values.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValues.primaryBlue;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        scaffoldBackgroundColor: ColorValues.primaryBackground,
        canvasColor: ColorValues.primaryBackground,
        brightness: Brightness.light,
        iconTheme: IconThemeData(size: 6.w),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.white),
          toolbarTextStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, letterSpacing: 0.5),
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, letterSpacing: 0.5, color: Colors.black),
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          )
        ),
        textTheme: GoogleFonts.interTextTheme());
  }
}
