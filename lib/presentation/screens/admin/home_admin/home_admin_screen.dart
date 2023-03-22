import 'dart:convert';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/admin_drawer.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_app_bar.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_tab_bar.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/tab_bar_view_item.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_icon_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_animate.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_bg.dart';
import 'package:elmotatawera_events/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeAdminScreen extends StatelessWidget {
  List<EventModel> allEvent = [];

  @override
  Widget build(BuildContext context) {
    AppCubit myCubit = BlocProvider.of(context);

        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if (state is ScanQrSuccess) {
              if (jsonDecode(myCubit.qrCode) is Map<String,dynamic>) {

            } else if(state is ScanQrFailer){
                customToast(context,text:"" );
              }else if(state is CheckInvitationSuccess){
                print(myCubit.invitationData.toString()+"3333333333333");
                Navigator.pushNamed(context, RouteNameManager.attendanceScreen);
              }else if(state is CheckInvitationFailer){
                customToast(context,text: "state.errorMessage");
              }
            }
          },
          builder: (context, state) {
            print(" ******** ${state} ******** ");

            return C0ntainer(
              child: Scaffold(
                body: Stack(
                  children: [
                    DrawerBg(),
                    AdminDrawer(
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
                            length: 3,
                            child: Column(
                              children: [
                                CustomAppBar(
                                  onPressed: () {
                                    myCubit.openDrawer();
                                  },
                                ),
                                CustomTabBar(
                                  onTap: (index) {
                                    myCubit.changeTabIndex(index);
                                  },
                                  index: myCubit.currentTabIndex,
                                ),
                                Expanded(
                                  child: tabBarViewItem(
                                      myCubit)[myCubit.currentTabIndex],
                                ),
                              ],
                            ),
                          ),
                        ),
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: ColorManager.terkwazColor,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNameManager.addEventScreen);
                          },
                          child: Icon(Icons.event),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(12.sp),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        onTap: () async {
                          await myCubit.scanQR();
                          if (jsonDecode(myCubit.qrCode) is Map<String,dynamic>) {
                            await myCubit.checkInvitationData(GuestModel.fromQrCode(jsonDecode(myCubit.qrCode))).then((v){
                              Navigator.pushNamed(context, RouteNameManager.attendanceScreen);
                            });
                          }else{
                            customToast(context,text: "invalide invitation");
                          }

                        },
                        iconData: Icons.qr_code_scanner,
                        text: "Check Invite",
                      ), CustomIconButton(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNameManager.newResponsibleScreen);
                        },
                        iconData: Icons.person_add_alt_1_sharp,
                        text: "New Responsible",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
