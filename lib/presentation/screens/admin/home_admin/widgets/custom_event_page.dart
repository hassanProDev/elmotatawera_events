import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomEventPage extends StatelessWidget {
  List<EventModel> eventModelList = [];

  CustomEventPage({Key? key, required this.eventModelList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: ListView.builder(
          itemCount: eventModelList.length,
          itemBuilder: (_, index) {
            return ActivityItem(
              eventModel: eventModelList[index],
              onTap: () {
                print(eventModelList[index].description + index.toString());
                EventModel eventModel = eventModelList[index];
                print(eventModel);
                BlocProvider.of<AppCubit>(context)
                    .getSelectedEventModel(eventModelList[index]);
                Navigator.pushNamed(context, RouteNameManager.adminEventScreen);
              },
            );
          }),
    );
  }
}
