import 'dart:math';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return CustomContainer(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ColorManager.skyColor, ColorManager.deepBlue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: 200,
                    child: Column(
                      children: [
                        // DrawerHeader(child: child)
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                title: Text("data"),
                              ),
                              ListTile(
                                title: Text("data"),
                              ),
                              ListTile(
                                title: Text("data"),
                              ),
                              ListTile(
                                title: Text("data"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 500),
                    builder: (_, val, widget) {
                      return (Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setEntry(0, 3, 200 * val)
                          ..rotateY((pi / 6) * val),
                        child: Scaffold(
                          appBar: AppBar(
                            leading: InkWell(
                              onTap: () {
                                // BlocProvider.of<AppCubit>(context).myTruth();
                              },
                              child: Icon(Icons.menu),
                            ),
                            backgroundColor: ColorManager.terkwazColor,
                            centerTitle: true,
                            title: Text("asdsadasd"),
                          ),
                        ),
                      ));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
