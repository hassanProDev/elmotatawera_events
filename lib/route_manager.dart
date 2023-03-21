import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/add_event_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/admin_event_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/update_event_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/event/widgets/attended_guests_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/home_admin/home_admin_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/new_responsible_screen/new_responsible_screen.dart';
import 'package:elmotatawera_events/presentation/screens/admin/new_responsible_screen/pages/add_admin_screen/add_admin.dart';
import 'package:elmotatawera_events/presentation/screens/admin/new_responsible_screen/pages/add_security_screen/add_security_screen.dart';
import 'package:elmotatawera_events/presentation/screens/attendance_Screen/attendance_Screen.dart';
import 'package:elmotatawera_events/presentation/screens/chat_screen/chat_screen.dart';
import 'package:elmotatawera_events/presentation/screens/guest/guest_event_screen/guest_event_screen.dart';
import 'package:elmotatawera_events/presentation/screens/guest/home_guest_screen/home_guest_screen.dart';
import 'package:elmotatawera_events/presentation/screens/invitation_screen/qr_invite_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/login_screen.dart';
import 'package:elmotatawera_events/presentation/screens/registration/signup_screen.dart';
import 'package:elmotatawera_events/presentation/screens/security/home_security_screen/home_security_screen.dart';
import 'package:elmotatawera_events/presentation/screens/splash_screen/splash_screen.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNameManager.splashScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(
                  child: SplashScreen(),
                ));
      case RouteNameManager.chatScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(
                  child: ChatScreen(),
                ));
      case RouteNameManager.signUpScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: SignUpScreen()));
      case RouteNameManager.newResponsibleScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: NewResponsibleScreen()));
      case RouteNameManager.addAdminScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AddAdminScreen()));
      case RouteNameManager.addEventScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AddEventScreen()));
      case RouteNameManager.updateEventScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: UpdateEventScreen()));
      case RouteNameManager.addSecurityScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AddScurityScreen()));
      case RouteNameManager.loginScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: LoginScreen()));
      case RouteNameManager.homeAdminScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: HomeAdminScreen()));
      case RouteNameManager.adminEventScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AdminEventScreen()));
      case RouteNameManager.inviteScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: QRInvititionScreen()));
      case RouteNameManager.guestAttendanceScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AttendedGuestsScreen()));
      case RouteNameManager.attendanceScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: AttendanceScreen()));
      case RouteNameManager.homeGuestScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: HomeGuestScreen()));
      case RouteNameManager.guestEventScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: GuestEventScreen()));
      case RouteNameManager.homeSecurityScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: HomeSecurityScreen()));
      case RouteNameManager.homeMasterScreen:
        return MaterialPageRoute(
            builder: (_) => SafeArea(child: MasterScreen()));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("your account is banned no page found! "),
                  ),
                ));
    }
  }
}
