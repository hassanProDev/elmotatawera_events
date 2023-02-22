import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class TextBlue extends StatelessWidget {
  String text;
  double? fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  FontStyle? fontStyle;

  TextBlue(
    this.text, {
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.w),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2!.copyWith(
            fontSize: fontSize ?? SizeManager.size10,
            fontStyle: fontStyle ?? FontStyle.normal,
            fontWeight: fontWeight ?? FontWeight.normal),
        textAlign: textAlign,
      ),
    );
  }
}
