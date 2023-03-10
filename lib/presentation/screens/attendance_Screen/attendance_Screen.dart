import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/attendence_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
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
              ? Scaffold(
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
                          "Count : " +
                              myCubit.invitationData!.guestData.peopleCount
                                  .toString(),
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
                                myCubit.invitationData!.guestData.attendance =
                                    true;
                                await myCubit
                                    .updateGuestData(myCubit.invitationData!);
                                myCubit
                                    .addAttendance(AttendanceModel(
                                      attendanceData: AttendanceData(
                                          title: myCubit.invitationData!
                                              .guestData.titleEvent,
                                          firstName: myCubit.invitationData!
                                              .guestData.firstName,
                                          lastName: myCubit.invitationData!
                                              .guestData.lastName,
                                          uid: myCubit.invitationData!.uid,
                                          attendedWithId:
                                              myCubit.getUserData!.uid),
                                      docId: myCubit.invitationData!.docId,
                                    ))
                                    .then((value) => Navigator.pop(context));
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
