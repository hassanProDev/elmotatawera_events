import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/widgets/event_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminEventScreen extends StatelessWidget {
  var panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);

    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: eventPages[myCubit.eventBottomNavIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.blueColor,
          child: Icon(Icons.chat),
          onPressed: () async{
            // myCubit.getSelectedEventModel(myCubit.selectedEventModel!);
            myCubit.getAllMessage(myCubit.selectedEventModel!.eventData.docId!);
            print(" ********* all messages **************");
            print(myCubit.allMessages);
            Navigator.pushNamed(context, RouteNameManager.chatScreen);
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: ColorManager.blueColor,
          backgroundColor: ColorManager.redColor,
          items: <Widget>[
            Icon(
              Icons.event,
              size: 30,
              color: ColorManager.offWhite,
            ),
            Icon(
              Icons.people_outline,
              size: 30,
              color: ColorManager.offWhite,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: ColorManager.offWhite,
            ),
            Icon(
              Icons.add,
              size: 30,
              color: ColorManager.offWhite,
            ),
          ],
          onTap: (index) {
            myCubit.changeEventBottomNavIndex(index);
          },
        ),
      ),
    );
  }
}
