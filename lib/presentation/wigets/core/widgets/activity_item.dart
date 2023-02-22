import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_terkwaz.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ActivityItem extends StatelessWidget {
  final String? img;
  final String? title;
  final String? location;
  final String? price;
  final VoidCallback? onTap;

  const ActivityItem({
    Key? key,
    this.img,
    this.price,
    this.title,
    this.location,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp)),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 20.h,
                child: ClipRRect(
                  child: Image.asset(
                    img!,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.sp),
                    topLeft: Radius.circular(16.sp),
                  ),
                ),
              ),
              ListTile(
                title: TextBlue(title ?? "title",fontSize: SizeManager.size16,),
                subtitle: TextDeepBlue("location $location"),
                trailing: TextTerkwaz("price $price"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
