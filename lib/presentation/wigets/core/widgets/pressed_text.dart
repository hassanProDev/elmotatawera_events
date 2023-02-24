import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalPressedText extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const GlobalPressedText(
      {Key? key, required this.text, this.color = Colors.blue, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: SizeManager.size12,
          color: color,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
