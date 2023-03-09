

import 'dart:async';

import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
customToast(BuildContext context, {String? text,Color? color=ColorManager.blueColor,IconData? icon,int? milliseconds }){
  showDialog(context: context, builder: (context){
    Timer(Duration(milliseconds: milliseconds??2000),(){
      // Navigator.pop(context);
    });
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child: Row(mainAxisSize: MainAxisSize.min,
          children: [
          Text(text??""),SizedBox(width: 2.w,),Icon(icon)
        ],),
      ),
    );
  });
}