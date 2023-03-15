import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? color;

  final Function? onTap;

  const CustomButton(
      {Key? key, this.text, this.color = ColorManager.blueColor, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        await BlocProvider.of<AppCubit>(context).firstGen();
        onTap!();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.sp),
        ),
        child: TextOffWhite(
          text!,
          fontSize: SizeManager.size15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
