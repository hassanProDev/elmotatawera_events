
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/registration/signup_screen.dart';
import 'package:flutter/material.dart';


class AddScurityScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SignUpScreen(userType: RouteNameManager.homeSecurityScreen,);
  }
}
