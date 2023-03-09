import 'dart:io';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatelessWidget {
  // EventPage({Key? key,required this.myCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit=BlocProvider.of(context);
    return SlidingUpPanel(
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      color: Colors.transparent,
      body: myCubit.selectedEventModel!.img==null? Center(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            GlobalRichText(firstString: "Using",secondString: "El Motatawera",),
            SizedBox(height: SizeManager.size28,),
            CustomButton(text: "Attendance",onTap: (){

            },)
          ],
        ),
      ): Image.file(
        File(myCubit.selectedEventModel!.img!),
        fit: BoxFit.fill,
      ),

      panelBuilder: (scroller) => Container(
        padding: EdgeInsets.all(SizeManager.size12),
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeManager.size22),
            topLeft: Radius.circular(SizeManager.size22),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextBlue(
              myCubit.selectedEventModel!.title,
              fontSize: SizeManager.size18,
              fontWeight: FontWeight.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBlue(
                  myCubit.selectedEventModel!.isPaid ? "Paid" : "un paid",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
                TextBlue(
                  "price : ${myCubit.selectedEventModel!.price}",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBlue(
                  "${myCubit.selectedEventModel!.dateTime.year} - ${myCubit.selectedEventModel!.dateTime.month}  - ${myCubit.selectedEventModel!.dateTime.day} ",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
                TextBlue(
                  "${myCubit.selectedEventModel!.dateTime.hour}:${myCubit.selectedEventModel!.dateTime.minute} ",
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                )
              ],
            ),
            TextBlue(
              "Location : ${myCubit.selectedEventModel!.location}",
              fontWeight: FontWeight.bold,
              fontSize: SizeManager.size11,
            ),
            GlobalPressedText(
              text: "Get Maps",
              onTap: () async{
                if (!await launchUrl(Uri.parse(myCubit.selectedEventModel!.locationUrl))) {
                  throw Exception('Could not launch ${myCubit.selectedEventModel!.locationUrl}');
                }
              },
            ),
            TextBlue(
               "Description",
              fontWeight: FontWeight.bold,
              fontSize: SizeManager.size12,
            ),
            TextBlue(
              myCubit.selectedEventModel!.description ?? "",
              fontWeight: FontWeight.bold,
              fontSize: SizeManager.size10,
            ),
            TextBlue("People Count: "+
              myCubit.selectedEventModel!.peopleCount.toString(),
              fontWeight: FontWeight.bold,
              fontSize: SizeManager.size12,
            ),
          ],
        ),
      ),
    );
  }
}
