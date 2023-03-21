import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: myCubit.invitationData != null
          ? myCubit.invitationData!.isConfirmed
              ? C0ntainer(
                  child: Scaffold(
                    body: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: SizeManager.size12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeManager.size22),
                            child: GlobalRichText(
                              firstString: "Attendance",
                              secondString: "Record",
                            ),
                          ),
                          TextDeepBlue(
                            myCubit.invitationData!.guestData.titleEvent,
                            textAlign: TextAlign.center,
                            fontSize: SizeManager.size18,
                            fontWeight: FontWeight.bold,
                          ),
                          TextDeepBlue(
                            "Available Invite :${myCubit.invitationData!.guestData.availableInvite}",
                            textAlign: TextAlign.center,
                            fontSize: SizeManager.size18,
                            fontWeight: FontWeight.bold,
                          ),
                          TextDeepBlue(
                            myCubit.invitationData!.guestData.firstName +
                                " " +
                                myCubit.invitationData!.guestData.lastName,
                            fontSize: SizeManager.size14,
                            fontWeight: FontWeight.bold,
                          ),
                          TextDeepBlue(
                            myCubit.invitationData!.isConfirmed
                                ? "Confirmed"
                                : "Un Confirmed",
                            fontSize: SizeManager.size14,
                            fontWeight: FontWeight.bold,
                          ),
                          TextDeepBlue(
                            myCubit.invitationData!.guestData.phone,
                            fontSize: SizeManager.size14,
                            fontWeight: FontWeight.bold,
                          ),
                          TextDeepBlue(
                            "Count : ${myCubit.invitationData!.guestData.peopleCount}",
                            fontSize: SizeManager.size14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !myCubit.invitationData!.guestData.attendance
                            ? CustomButton(
                                text: "Attended",
                                onTap: () async {
                                  if (myCubit.invitationData!.guestData
                                          .availableInvite ==
                                      1) {
                                    myCubit.invitationData!.guestData
                                        .attendance = true;
                                    myCubit.invitationData!.guestData
                                        .availableInvite--;
                                    await myCubit.updateGuestData(
                                        myCubit.invitationData!);
                                    await myCubit
                                        .getUpdateDataForAttendance(
                                            myCubit.invitationData!,
                                            myCubit.getUserData!.uid)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  } else if (myCubit.invitationData!.guestData
                                          .availableInvite ==
                                      myCubit.invitationData!.guestData
                                          .peopleCount) {
                                    myCubit.invitationData!.guestData
                                        .availableInvite--;
                                    myCubit
                                        .addAttendance(
                                            AttendanceModel(
                                              attendanceData: AttendanceData(
                                                attendanceCount: myCubit
                                                        .invitationData!
                                                        .guestData
                                                        .peopleCount -
                                                    myCubit
                                                        .invitationData!
                                                        .guestData
                                                        .availableInvite,
                                                title: myCubit.invitationData!
                                                    .guestData.titleEvent,
                                                firstName: myCubit
                                                    .invitationData!
                                                    .guestData
                                                    .firstName,
                                                lastName: myCubit
                                                    .invitationData!
                                                    .guestData
                                                    .lastName,
                                                uid:
                                                    myCubit.invitationData!.uid,
                                                attendedWithId:
                                                    myCubit.getUserData!.uid,
                                                invitationCount: myCubit
                                                    .invitationData!
                                                    .guestData
                                                    .peopleCount,
                                              ),
                                              docId:
                                                  myCubit.invitationData!.docId,
                                            ),
                                            myCubit.invitationData!)
                                        .then(
                                            (value) => Navigator.pop(context));
                                  } else {
                                    myCubit.invitationData!.guestData
                                        .availableInvite--;

                                    await myCubit
                                        .updateGuestData(
                                            myCubit.invitationData!)
                                        .then((e) {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                              )
                            : CustomButton(
                                text: "already attended",
                                color: ColorManager.redColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  body: Center(
                    child: TextDeepBlue(
                      "This Guest Not confirmed",
                      fontSize: SizeManager.size28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
          : Center(
              child: Text("No Invitation data"),
            ),
    );
  }
}
