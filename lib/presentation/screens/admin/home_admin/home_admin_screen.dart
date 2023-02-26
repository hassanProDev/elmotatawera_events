import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_app_bar.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_event_page.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_tab_bar.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_animate.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_bg.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAdminScreen extends StatelessWidget {
  List<EventModel> allEvent = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit myCubit = BlocProvider.of(context);
        print(" ******** ${myCubit.allEventList} ******** ");
        return C0ntainer(
          child: Scaffold(
            body: Stack(
              children: [
                DrawerBg(),
                GlobalDrawer(onPressed: (){
                  myCubit.openDrawer();
                },),
                DrawerAnimate(
                  drawerSwitch: myCubit.drawerValue,
                  child: Scaffold(
                    body: SafeArea(
                      child: DefaultTabController(
                        animationDuration: Duration(seconds: 1),
                        length: 3,
                        child: Column(
                          children: [
                            CustomAppBar(),
                            CustomTabBar(

                              onTap: (index) {
                                myCubit.changeTabIdex(index);
                              },
                              index: myCubit.currentTabIndex,
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                CustomEventPage(
                                    eventModelList: myCubit.allEventList),
                                CustomEventPage(
                                    eventModelList: myCubit.allActiveEvent),
                                CustomEventPage(
                                    eventModelList: myCubit.allUnActiveEvent),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: ColorManager.terkwazColor,
                      onPressed: () {
                        myCubit.openDrawer();
                      },
                      child: Icon(Icons.event),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
