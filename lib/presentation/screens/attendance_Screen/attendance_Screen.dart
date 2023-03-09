import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
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
      child:myCubit.invitationData!=null? Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlobalRichText(
              firstString: "Attendance",
              secondString: "Record",
            ),
            TextDeepBlue(myCubit.invitationData!.guestData.titleEvent,textAlign: TextAlign.center,),
            TextDeepBlue(myCubit.invitationData!.guestData.firstName +
                " " +
                myCubit.invitationData!.guestData.lastName),
            TextDeepBlue(myCubit.invitationData!.isConfirmed
                ? "Confirmed"
                : "Un Confirmed"),
            TextDeepBlue(myCubit.invitationData!.guestData.phone),
            TextDeepBlue(
                "Count : " + myCubit.invitationData!.guestData.peopleCount.toString()),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           !myCubit.invitationData!.guestData.attendance? CustomButton(
              text: "Attended",
              onTap: () {
                myCubit.invitationData!.guestData.attendance=true;
                myCubit.updateGuestData(myCubit.invitationData!);
                myCubit.addAttendance(AttendanceModel(
                    title: myCubit.invitationData!.guestData.titleEvent,
                    firstName: myCubit.invitationData!.guestData.firstName,
                    lastName: myCubit.invitationData!.guestData.lastName,
                    uid: myCubit.invitationData!.uid,
                    docId: myCubit.invitationData!.docId,
                    attendedWithId: myCubit.getUserData!.uid)).then((value) => Navigator.pop(
                    context));
              },
            ):CustomButton(text: "already attended",color: ColorManager.redColor,onTap: (){
              Navigator.pop(context);
           },),
          ],
        ),
      ):Center(
        child: Text("No Invitation data"),
      ),
    );
  }
}
