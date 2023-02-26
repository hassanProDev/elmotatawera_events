import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTabItem extends StatelessWidget {
  bool? isSelected;
  String? text;

  CustomTabItem({Key? key, this.isSelected, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 10.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeManager.size12),
          color: isSelected! ? ColorManager.blueColor : Colors.white),
      child: isSelected! ? TextOffWhite(text!,fontWeight: FontWeight.bold,) : TextBlue(text!,fontWeight: FontWeight.bold,),
    );
  }
}
