import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalPressedText extends StatelessWidget {
  final String hint;
  final String? text;
  final Color color;
  final VoidCallback? onTap;
  final double? fontSize;
  final FontWeight? fontWeight;

  const GlobalPressedText(
      {Key? key, this.text, this.color = Colors.blue, this.onTap,this.fontSize,this.fontWeight,this.hint=''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text??hint,
        style: GoogleFonts.poppins(
          fontSize: fontSize??SizeManager.size12,
          color: color,
          decoration: TextDecoration.underline,
          fontWeight: fontWeight,
        ),textAlign: TextAlign.center,
      ),
    );
  }
}
