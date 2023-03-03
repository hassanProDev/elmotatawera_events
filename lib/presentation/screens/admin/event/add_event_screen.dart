import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventScreen extends StatelessWidget {
  DateTime? eventDateTime;

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit=BlocProvider.of(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            GlobalRichText(
              firstString: "New",
              secondString: " Event",
            ),
            GlobalPressedText(
              onTap: () async {
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
                myCubit.getSelectedDate( DateTime(
                  dateTime.year,
                  dateTime.month,
                  dateTime.day,
                  timeOfDay.hour,
                  timeOfDay.minute,
                ));
              },
              hint: "Pick Event Date & Time",
              text: myCubit.eventDateTime != null
                  ? "Date : ${myCubit.eventDateTime!.year} / ${myCubit.eventDateTime!
                  .month} / ${myCubit.eventDateTime!.day} - Time : ${myCubit.eventDateTime!
                  .hour}:${myCubit.eventDateTime!.minute}"
                  : null,
              color: ColorManager.blueColor,
            ),
            CustomTextFormField(
              text: "Title",
            ),
            CustomTextFormField(
              text: "location",
            ),
            CustomTextFormField(
              text: "location url",
              keyboardType: TextInputType.url,
              regexCondition: urlRegex,
            ),
            CustomTextFormField(
              text: "price",
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              text: "Title",
            ),
            CustomTextFormField(
              text: "Title",
            ),
          ],
        ),
      ),
    );
  }
}
