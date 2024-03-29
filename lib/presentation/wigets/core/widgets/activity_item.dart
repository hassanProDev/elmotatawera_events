import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_terkwaz.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ActivityItem extends StatelessWidget {

  final VoidCallback? onTap;
  final EventModel? eventModel;

  const ActivityItem({
    Key? key,
    this.onTap,
    this.eventModel
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
              eventModel?.eventData.img!=null?Container(height: 20.h,
                child: ClipRRect(
                  child: Image.asset(
                    eventModel!.eventData.img!,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.sp),
                    topLeft: Radius.circular(16.sp),
                  ),
                ),
              ):SizedBox(),
              ListTile(
                title: TextBlue(eventModel!.eventData.title ?? "title",fontSize: SizeManager.size16,),
                subtitle: TextDeepBlue("location ${eventModel!.eventData.location}"),
                trailing: TextTerkwaz("price ${eventModel!.eventData.price}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
