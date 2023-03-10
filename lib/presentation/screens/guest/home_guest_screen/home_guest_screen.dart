import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_app_bar.dart';
import 'package:elmotatawera_events/presentation/screens/guest/home_guest_screen/widgets/invitation_tile.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/activity_item.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_animate.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_bg.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_drawer.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeGuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return C0ntainer(
          child: Scaffold(
            body: Stack(
              children: [
                DrawerBg(),
                GlobalDrawer(
                  onPressed: () {
                    myCubit.openDrawer();
                  },
                ),
                DrawerAnimate(
                  drawerSwitch: myCubit.drawerValue,
                  child: Scaffold(
                    body: SafeArea(
                      child: DefaultTabController(
                        animationDuration: Duration(seconds: 1),
                        length: 2,
                        child: Column(
                          children: [
                            CustomAppBar(
                              onPressed: () {
                                myCubit.openDrawer();
                              },
                            ),
                            TabBar(
                              indicatorColor: Colors.transparent,
                                onTap: (index) {
                                  myCubit.changeTabIndex(index);
                                },
                                tabs: [
                                  CustomTabItem(
                                    text: "Active Events",
                                    isSelected: 0 == myCubit.currentTabIndex,
                                  ),
                                  CustomTabItem(
                                    text: "My Invitations",
                                    isSelected: 1 == myCubit.currentTabIndex,
                                  )
                                ]),
                            Expanded(
                                child: [
                              ListView.builder(
                                  itemCount: myCubit.allActiveEvent.length,
                                  itemBuilder: (context, index) {
                                    return ActivityItem(
                                      eventModel: myCubit.allActiveEvent[index],
                                      onTap: () {
                                        myCubit.changeTabIndex(0);
                                        myCubit.changeGuestTabIndex(0);
                                        myCubit.changeEventBottomNavIndex(0);
                                        myCubit.getSelectedEventModel(
                                            myCubit.allActiveEvent[index]);
                                        myCubit.getMyGuests(
                                            myCubit.allActiveEvent[index]
                                                .eventData.docId!,
                                            myCubit.getUserData!.uid);
                                        Navigator.pushNamed(context,
                                            RouteNameManager.guestEventScreen);
                                      },
                                    );
                                  }),
                              ListView.builder(
                                  itemCount: myCubit.getMyInvitationData.length,
                                  itemBuilder: (context, index) {
                                    return InvitationTile(
                                      guestModel:
                                          myCubit.getMyInvitationData[index],
                                    );
                                  }),
                            ][myCubit.currentTabIndex]),
                          ],
                        ),
                      ),
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
