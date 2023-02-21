import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  String? text;
  String? regexCondition;
  TextEditingController? controller;
  bool isPassword;
  IconData? iconData;
  Function? onClick;
  Function(String)? onChange;

  CustomTextFormField(
      {this.regexCondition,
      this.text,
      this.controller,
      this.iconData,
      this.onClick,
      this.isPassword = false,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.w),
      child: TextFormField(
        onChanged: onChange,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $text Currect";
          }
          if (regexCondition != null) {
            if (!RegExp('$regexCondition').hasMatch(value)) {
              return 'your $text must be $regexCondition';
            }
          }
        },
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
          labelText: text!.toUpperCase(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          suffixIcon: iconData != null
              ? InkWell(
                  onTap: () {
                    onClick!();
                  },
                  child: Icon(
                    iconData,
                    // color: ColorManager.darkOrangeColor,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
