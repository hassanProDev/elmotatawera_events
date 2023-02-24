import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/registration/signup_screen.dart';
import 'package:flutter/material.dart';

class AddAdminScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SignUpScreen(userType: RouteNameManager.homeMasterScreen,);
  }
}
