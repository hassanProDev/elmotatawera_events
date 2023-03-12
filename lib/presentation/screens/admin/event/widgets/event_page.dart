import 'dart:io';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
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
    AppCubit myCubit = BlocProvider.of(context);
    return C0ntainer(
      child: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        color: Colors.transparent,
        body: myCubit.selectedEventModel!.eventData.img == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalRichText(
                      firstString: "Using",
                      secondString: "El Motatawera",
                    ),
                    SizedBox(
                      height: SizeManager.size28,
                    ),
                    CustomButton(
                      text: "Attendance",
                      onTap: () {
                        myCubit.getAllAttendence(myCubit.selectedEventModel!.eventData.docId!);
                        Navigator.pushNamed(context, RouteNameManager.guestAttendanceScreen);
                      },
                    )
                  ],
                ),
              )
            : Image.file(
                File(myCubit.selectedEventModel!.eventData.img!),
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
                myCubit.selectedEventModel!.eventData.title,
                fontSize: SizeManager.size18,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBlue(
                    myCubit.selectedEventModel!.eventData.isPaid
                        ? "Paid"
                        : "un paid",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  TextBlue(
                    "price : ${myCubit.selectedEventModel!.eventData.price}",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBlue(
                    "${myCubit.selectedEventModel!.eventData.dateTime.year} - ${myCubit.selectedEventModel!.eventData.dateTime.month}  - ${myCubit.selectedEventModel!.eventData.dateTime.day} ",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  ),
                  TextBlue(
                    "${myCubit.selectedEventModel!.eventData.dateTime.hour}:${myCubit.selectedEventModel!.eventData.dateTime.minute} ",
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size12,
                  )
                ],
              ),
              TextBlue(
                "Location : ${myCubit.selectedEventModel!.eventData.location}",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size11,
              ),
              GlobalPressedText(
                text: "Get Maps",
                onTap: () async {
                  if (!await launchUrl(
                      Uri(path:myCubit.selectedEventModel!.eventData.locationUrl,scheme: ""))) {
                    throw Exception(
                        'Could not launch ${myCubit.selectedEventModel!.eventData.locationUrl}');
                  }
                },
              ),
              TextBlue(
                "Description",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size12,
              ),
              TextBlue(
                myCubit.selectedEventModel!.eventData.description ?? "",
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size10,
              ),
              TextBlue(
                "People Count: " +
                    myCubit.selectedEventModel!.eventData.peopleCount.toString(),
                fontWeight: FontWeight.bold,
                fontSize: SizeManager.size12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
