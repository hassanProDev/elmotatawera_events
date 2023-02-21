 import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/home_admin_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/login_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/signup_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RouteNameManager.signUpScreen:
        return MaterialPageRoute(builder: (_)=> SignUpScreen());
      case RouteNameManager.loginScreen:
        return MaterialPageRoute(builder: (_)=> LoginScreen());
      case RouteNameManager.homeAdminScreen:
        return MaterialPageRoute(builder: (_)=> HomeAdminScreen());
      case RouteNameManager.homeGuestScreen:
        return MaterialPageRoute(builder: (_)=> HomeAdminScreen());
      case RouteNameManager.homeSecurityScreen:
        return MaterialPageRoute(builder: (_)=> HomeAdminScreen());
      default:
        return MaterialPageRoute(builder: (_)=>Scaffold(
          body: Center(
            child: Text("no page found! "),
          ),
        ));
    }
  }
 }