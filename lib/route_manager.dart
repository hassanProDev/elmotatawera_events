import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/add_security/add_admin.dart';
import 'package:elmotatawera_events/presentation/screens/admin/add_security_screen/add_security_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/admin_event_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/home_admin_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/login_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/signup_screen.dart';
import 'package:elmotatawera_events/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNameManager.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteNameManager.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RouteNameManager.addAdminScreen:
        return MaterialPageRoute(builder: (_) => AddAdminScreen());
      case RouteNameManager.addSecurityScreen:
        return MaterialPageRoute(builder: (_) => AddScurityScreen());
      case RouteNameManager.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteNameManager.homeAdminScreen:
        return MaterialPageRoute(builder: (_) => HomeAdminScreen());
      case RouteNameManager.adminEventScreen:
        return MaterialPageRoute(builder: (_) => AdminEventScreen());
      case RouteNameManager.homeGuestScreen:
        return MaterialPageRoute(builder: (_) => HomeAdminScreen());
      case RouteNameManager.homeSecurityScreen:
        return MaterialPageRoute(builder: (_) => HomeAdminScreen());
      case RouteNameManager.homeMasterScreen:
        return MaterialPageRoute(builder: (_) => HomeAdminScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("no page found! "),
                  ),
                ));
    }
  }
}
