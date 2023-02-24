import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/activity_item.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_animate.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/drawer_bg.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_drawer.dart';
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
        AppCubit myCubit = BlocProvider.of(context);
        return C0ntainer(
          child: Scaffold(
            body: Stack(
              children: [
                DrawerBg(),
                GlobalDrawer(),
                DrawerAnimate(
                  drawerSwitch: 0,
                  child: Scaffold(
                    body: SafeArea(
                      child: ListView.builder(
                          itemCount: 0,
                          itemBuilder: (_, index) {
                            return ActivityItem(
                              img: "assets/images/activity_img.jpg",
                            );
                          }),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.event),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
