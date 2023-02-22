import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:flutter/material.dart';

class DrawerBg extends StatelessWidget {
  const DrawerBg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorManager.skyColor, ColorManager.deepBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
