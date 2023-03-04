import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddEventScreen extends StatelessWidget {
  String? title;
  String? description;
  String? location;
  String? locationUrl;
  int? peopleCount;
  double? price;
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
                  onChange: (v) {
                    title = v;
                  },
                ),
                CustomTextFormField(
                  controller: myCubit.locationController,
                  text: "location",
                  onChange: (v) {
                    location = v;
                  },
                ),
                CustomTextFormField(
                  controller: myCubit.locationUrlController,
                  onChange: (v) {
                    locationUrl = v;
                  },
                  text: "location url",
                  keyboardType: TextInputType.url,
                  // regexCondition: urlRegex,
                ),
                CustomTextFormField(
                  controller: myCubit.priceController,
                  onChange: (v) {
                    price = double.parse(v);
                  },
                  text: "price",
                  keyboardType: TextInputType.number,
                ),
                CustomTextFormField(
                  controller: myCubit.peopleCountController,
                  onChange: (v) {
                    peopleCount = int.parse(v);
                  },
                  text: "Guest Count",
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: myCubit.descriptionController,
                  onChanged: (v) {
                    description = v;
                  },
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
                  onTap: () async{
                    if(myCubit.eventFormKey.currentState!.validate()){
                      await myCubit.addEvent(EventModel(
                        uid: myCubit.getUserData!.uid,
                        title: title!,
                        location: location!,
                        dateTime: myCubit.eventDateTime!,
                        peopleCount: peopleCount!,
                        description: description!,
                        price: price!,
                        isPaid: price! > 0,
                        locationUrl: locationUrl!,
                        isEventDone: false,
                      )).then((value) {
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
