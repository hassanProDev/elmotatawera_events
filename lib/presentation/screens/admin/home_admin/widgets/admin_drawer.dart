import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AdminDrawer extends StatelessWidget {
  void Function()? onPressed;

  AdminDrawer({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);
    return SafeArea(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(SizeManager.size10),
        child: Column(
          children: [
            // DrawerHeader(child: child)
            Expanded(
              child: ListView(
                children: [
                  IconButton(onPressed: onPressed, icon: Icon(Icons.clear)),
                  TextOffWhite(
                    "User",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    myCubit.getUserData!.userData.userType,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Name",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    myCubit.getUserData!.userData.firstName +
                        " " +
                        BlocProvider.of<AppCubit>(context)
                            .getUserData!
                            .userData
                            .lastName,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Phone",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    myCubit.getUserData!.userData.phone,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Email",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    myCubit.getUserData!.userData.email,
                    fontSize: SizeManager.size10,
                  ),
                  TextDeepBlue(
                    "The Founder",
                    fontSize: SizeManager.size18,
                    fontWeight: FontWeight.bold,
                  ),
                  TextOffWhite(
                    "Hassan Ashraf",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    "01114898895",
                    fontSize: SizeManager.size12,
                  ),

                  InkWell(
                    onTap: () async {
                      myCubit.getAllBandedUsers();
                      myCubit.getAllActiveUsers();
                      Navigator.pushNamed(context, RouteNameManager.usersScreen);
                      myCubit.openDrawer();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: ColorManager.greenColor,
                        ),
                        SizedBox(
                          width: 2.sp,
                        ),
                        TextOffWhite("All Users"),
                      ],
                    ),
                  ), InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, RouteNameManager.changePasswordScreen);
                      myCubit.openDrawer();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.password,
                          color: ColorManager.redColor,
                        ),
                        SizedBox(
                          width: 2.sp,
                        ),
                        TextOffWhite("Change Password"),
                      ],
                    ),
                  ),
              InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      await DefaultCacheManager().emptyCache();
                      await FirebaseAuth.instance.signOut().then((value) {
                        prefs.clear();
                        myCubit.openDrawer();
                        Restart.restartApp();
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     RouteNameManager.loginScreen, (route) => false);
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.power_settings_new_outlined,
                          color: ColorManager.redColor,
                        ),
                        SizedBox(
                          width: 2.sp,
                        ),
                        TextOffWhite("Exit"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
