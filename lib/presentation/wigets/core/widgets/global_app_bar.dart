
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      leading: InkWell(
        onTap: () {
        },
        child: Icon(Icons.menu),
      ),
      backgroundColor: ColorManager.blueColor,
      centerTitle: true,
      title: Text("asdsadasd"),
    );
  }
}
