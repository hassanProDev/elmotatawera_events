import 'package:elmotatawera_events/presentation/screens/admin/event/widgets/event_page.dart';
import 'package:elmotatawera_events/presentation/screens/admin/guest_admin_screen/add_guest.dart';
import 'package:elmotatawera_events/presentation/screens/admin/guest_admin_screen/confirmed_guest.dart';
import 'package:elmotatawera_events/presentation/screens/admin/guest_admin_screen/unconfirmed_guest.dart';
import 'package:flutter/material.dart';

List<Widget> eventPages = [
  EventPage(),
  ConfirmedGuestScreen(),
  UnConfirmedGuestScreen(),
  AddGuestScreen(),
];
