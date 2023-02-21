import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;

  final Function? onTap;
  const CustomButton({Key? key, this.text, this.color,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 3.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.sp),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
