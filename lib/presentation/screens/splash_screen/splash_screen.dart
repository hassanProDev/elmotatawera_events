import 'dart:async';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
    Timer.periodic(Duration(seconds: 2), (timer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('email') != null) {
        await BlocProvider.of<AppCubit>(context)
            .userLogin(prefs.getString("email")!, prefs.getString("password")!);
        Navigator.pushNamedAndRemoveUntil(
            context,
            BlocProvider.of<AppCubit>(context).getUserData!.userData.userType,
            (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNameManager.loginScreen, (route) => false);
      }
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlobalRichText(
              firstString: "El Motatawera",
              secondString: " Events",
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Founder Hassan Ashraf",
              style: GoogleFonts.greatVibes(
                  fontSize: SizeManager.size18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: ColorManager.deepBlue),
            ),
            Text(
              "01114898895",
              style: GoogleFonts.greatVibes(
                  fontSize: SizeManager.size15,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.deepBlue),
            )
          ],
        ),
      ),
    );
  }
}
