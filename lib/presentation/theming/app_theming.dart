import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheming {
  ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: ColorManager.offWhite,
      appBarTheme: AppBarTheme(),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(color: ColorManager.blackColor),
        headline2: GoogleFonts.poppins(color: ColorManager.blueColor),
        headline3: GoogleFonts.poppins(color: ColorManager.deepBlue),
        headline4: GoogleFonts.poppins(color: ColorManager.offWhite),
        headline5: GoogleFonts.poppins(color: ColorManager.terkwazColor),
      ));
}
