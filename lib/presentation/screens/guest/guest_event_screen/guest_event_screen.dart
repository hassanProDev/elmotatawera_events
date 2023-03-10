import 'dart:io';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/screens/guest/guest_event_screen/widgets/invitation_bottom_sheet.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);

    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: SlidingUpPanel(
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          color: Colors.transparent,
          body: myCubit.selectedEventModel!.eventData.img == null
              ? Center(
                child: GlobalRichText(
                    firstString: "Using",
                    secondString: "El Motatawera",
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
                    if (!await launchUrl(Uri.parse(
                        myCubit.selectedEventModel!.eventData.locationUrl))) {
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
                      myCubit.selectedEventModel!.eventData.peopleCount
                          .toString(),
                  fontWeight: FontWeight.bold,
                  fontSize: SizeManager.size12,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: myCubit.getMyGuestsData.isNotEmpty &&
                myCubit.getMyGuestsData[0].isConfirmed
            ? FloatingActionButton(
                backgroundColor: ColorManager.blueColor,
                child: Icon(Icons.chat),
                onPressed: () async {
                  // myCubit.getSelectedEventModel(myCubit.selectedEventModel!);
                  myCubit.getAllMessage(
                      myCubit.selectedEventModel!.eventData.docId!);
                  Navigator.pushNamed(context, RouteNameManager.chatScreen);
                },
              )
            : SizedBox(),
        bottomNavigationBar: myCubit.getMyGuestsData.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: "Get Invitation",
                    onTap: () {
                      invitationBottomSheet(
                          context,
                          GuestModel(
                              guestData: GuestData(
                                  firstName:
                                      myCubit.getUserData!.userData.firstName,
                                  lastName:
                                      myCubit.getUserData!.userData.lastName,
                                  peopleCount: myCubit.guestCount,
                                  phone: myCubit.getUserData!.userData.phone,
                                  adminPhone: myCubit
                                      .selectedEventModel!.eventData.adminPhone,
                                  paid: myCubit
                                      .selectedEventModel!.eventData.isPaid,
                                  eventDate: myCubit
                                      .selectedEventModel!.eventData.dateTime,
                                  titleEvent: myCubit
                                      .selectedEventModel!.eventData.title,
                                  attendance: false),
                              uid: myCubit.getUserData!.uid,
                              docId:
                                  myCubit.selectedEventModel!.eventData.docId!,
                              isConfirmed: !myCubit
                                  .selectedEventModel!.eventData.isPaid),
                          maxGuest: 5);
                    },
                  ),
                ],
              )
            : SizedBox(),
      ),
    );
  }
}
