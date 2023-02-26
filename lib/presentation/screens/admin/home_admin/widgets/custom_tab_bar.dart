import 'package:elmotatawera_events/presentation/screens/admin/home_admin/widgets/tab_item.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  void Function(int)? onTap;
  int? index;

  CustomTabBar({Key? key, this.onTap, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        indicatorColor: Colors.transparent,
        isScrollable: true,
        onTap: onTap,
        tabs: [
          CustomTabItem(
            text: "all events".toUpperCase(),
            isSelected: 0 == index,
          ),
          CustomTabItem(
            text: "active events".toUpperCase(),
            isSelected: 1 == index,
          ),
          CustomTabItem(
            text: "un active events".toUpperCase(),
            isSelected: 2 == index,
          ),
        ]);
  }
}
