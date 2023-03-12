import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/regex_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddEventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Form(
            key: myCubit.eventFormKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.sp),
                  child: GlobalRichText(
                    firstString: "New",
                    secondString: " Event",
                  ),
                ),
                GlobalPressedText(
                  onTap: () async {
                    myCubit.getSelectedDate(null);
                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)));
                    if (dateTime == null) return;
                    TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: dateTime.hour,
                        minute: dateTime.minute,
                      ),
                    );
                    if (timeOfDay == null) return;
                    myCubit.getSelectedDate(DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      timeOfDay.hour,
                      timeOfDay.minute,
                    ));
                  },
                  hint: "Pick Event Date & Time",
                  text: myCubit.eventDateTime != null
                      ? "Date : ${myCubit.eventDateTime!.year} / ${myCubit.eventDateTime!.month} / ${myCubit.eventDateTime!.day} - Time : ${myCubit.eventDateTime!.hour}:${myCubit.eventDateTime!.minute}"
                      : null,
                  color: ColorManager.blueColor,
                ),
                CustomTextFormField(
                  controller: myCubit.titleController,
                  text: "Title",
                ),
                CustomTextFormField(
                  controller: myCubit.locationController,
                  text: "location",
                ),
                CustomTextFormField(
                  controller: myCubit.locationUrlController,
                  text: "location url",
                  keyboardType: TextInputType.url,
                  regexCondition: RegexManager.locatinUrlRegex,
                ),
                CustomTextFormField(
                  controller: myCubit.priceController,
                  text: "price",
                  keyboardType: TextInputType.number,
                  regexCondition: RegexManager.priceRegex,
                ),
                CustomTextFormField(
                  controller: myCubit.peopleCountController,
                  text: "Guest Count",
                  keyboardType: TextInputType.number,
                  regexCondition: RegexManager.countRegex,
                ),
                TextFormField(
                  controller: myCubit.descriptionController,
                  minLines: 5,
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Event Description";
                    }
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 3.w),
                    labelText: "Description".toUpperCase(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
                CustomButton(
                  text: "Add Event",
                  onTap: () async {
                    if (myCubit.eventFormKey.currentState!.validate()) {
                      await myCubit
                          .addEvent(EventModel(
                        eventData: EventData(
                            uid: myCubit.getUserData!.uid,
                            title: myCubit.titleController.text,
                            location: myCubit.locationController.text,
                            dateTime: myCubit.eventDateTime!,
                            adminPhone: myCubit.getUserData!.userData.phone,
                            peopleCount:
                                int.parse(myCubit.peopleCountController.text),
                            description: myCubit.descriptionController.text,
                            price: double.parse(myCubit.priceController.text),
                            isPaid:
                                double.parse(myCubit.priceController.text) > 0,
                            locationUrl: myCubit.locationUrlController.text),
                        isEventDone: false,
                      ))
                          .then((value) {
                        myCubit.getSelectedDate(null);
                        myCubit.resetEventController();
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
    );
  }
}
