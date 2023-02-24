import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalRichText extends StatelessWidget {
  final String? firstString;
  final String? secondString;
  final double? fontSize;
  final Color? firstTextColor;
  final Color? secondTextColor;

  const GlobalRichText({
    Key? key,
    this.firstString,
    this.secondString,
    this.fontSize,
    this.firstTextColor,
    this.secondTextColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstString,
        style: GoogleFonts.poppins(
            color: firstTextColor??ColorManager.redColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize??SizeManager.size18),
        children: [
          TextSpan(
              text: secondString,
              style: GoogleFonts.poppins(
                  color: secondTextColor??ColorManager.deepBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize??SizeManager.size18)),
        ],
      ),
    );
  }
}
