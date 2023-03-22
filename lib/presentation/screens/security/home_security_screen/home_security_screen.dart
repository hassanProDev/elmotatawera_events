import 'dart:convert';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/custom_app_bar.dart';
import 'package:elmotatawera_events/presentation/screens/security/home_security_screen/widgets/security_drawer.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_icon_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_animate.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_bg.dart';
import 'package:elmotatawera_events/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeSecurityScreen extends StatelessWidget {

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
            Navigator.pushNamed(context, RouteNameManager.attendanceScreen);
          }else if(state is CheckInvitationFailer){
            customToast(context,text: "state.errorMessage");
          }
        }
      },
      builder: (context, state) {
        return C0ntainer(
          child: Scaffold(
            body: Stack(
              children: [
                DrawerBg(),
                SecurityDrawer(
                  onPressed: () {
                    myCubit.openDrawer();
                  },
                ),
                DrawerAnimate(
                  drawerSwitch: myCubit.drawerValue,
                  child: Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: [
                          CustomAppBar(
                            onPressed: () {
                              myCubit.openDrawer();
                            },
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(12.sp),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    onTap: () async {
                      await myCubit.scanQR();
                      if (jsonDecode(myCubit.qrCode) is Map<String,dynamic>) {
                        await myCubit.checkInvitationData(GuestModel.fromQrCode(jsonDecode(myCubit.qrCode))).then((v){
                          Navigator.pushNamed(context, RouteNameManager.attendanceScreen);
                        });
                      }else{
                      }
                    },
                    iconData: Icons.qr_code_scanner,
                    text: "Check Invite",
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
