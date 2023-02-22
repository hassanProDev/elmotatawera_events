

import 'dart:math';

import 'package:flutter/material.dart';

class DrawerAnimate extends StatelessWidget {
  final Widget? child;
  final double? drawerSwitch;
  const DrawerAnimate({Key? key,this.child,this.drawerSwitch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: drawerSwitch),
        duration: Duration(milliseconds: 500),
        builder: (_, val, widget) {
          return (Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setEntry(0, 3, 200 * val)
              ..rotateY((pi / 6) * val),
            child: child,
          ));
        });
  }
}
