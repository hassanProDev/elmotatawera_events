import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddGuestScreen extends StatelessWidget {
  String? firstName;
  String? lastName;
  String? phone;
  int? peopleCount;

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: myCubit.guestKeyForm,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    child: GlobalRichText(
                      firstString: "Add",
                      secondString: "Guest",
                    ),
                  ),
                  CustomTextFormField(
                    text: "first name",
                    controller: myCubit.guestFirstName,
                  ),
                  CustomTextFormField(
                    text: "last name",
                    controller: myCubit.guestLastName,
                  ),
                  CustomTextFormField(
                    text: "phone",
                    controller: myCubit.guestPhone,
                  ),
                  CustomTextFormField(
                    text: "people count",
                    keyboardType: TextInputType.number,
                    controller: myCubit.guestPeopleCount,
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  CustomButton(
                    text: "Add Guest",
                    onTap: () async {
                      if (myCubit.guestKeyForm.currentState!.validate()) {
                        await myCubit
                            .addGuest(GuestModel(
                                uid: myCubit.getUserData!.uid,
                                guestData: GuestData(
                                    firstName: myCubit.guestFirstName.text,
                                    lastName: myCubit.guestLastName.text,
                                    peopleCount: int.parse(
                                        myCubit.guestPeopleCount.text),
                                    phone: myCubit.guestPhone.text,
                                    eventDate:
                                        myCubit.selectedEventModel!.eventData.dateTime,
                                    adminPhone: myCubit.getUserData!.userData.phone,
                                    paid: myCubit.selectedEventModel!.eventData.isPaid,
                                    titleEvent:
                                        myCubit.selectedEventModel!.eventData.title,attendance: false),
                                docId: myCubit.selectedEventModel!.eventData.docId!,
                                isConfirmed: true,))
                            .then((value) {
                          myCubit.changeEventBottomNavIndex(0);
                          myCubit.resetGuestController();
                          Navigator.pop(context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
