import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_event_page.dart';
import 'package:flutter/material.dart';

List<Widget> tabBarViewItem(AppCubit myCubit) {
  return[
    CustomEventPage(eventModelList: myCubit.allEventList),
    CustomEventPage(eventModelList: myCubit.allActiveEvent),
    CustomEventPage(eventModelList: myCubit.allUnActiveEvent),
  ];
}
