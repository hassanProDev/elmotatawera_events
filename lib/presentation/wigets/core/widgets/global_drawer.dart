import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalDrawer extends StatelessWidget {
  void Function()? onPressed;

  GlobalDrawer({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(SizeManager.size10),
        child: Column(
          children: [
            // DrawerHeader(child: child)
            Expanded(
              child: ListView(
                children: [
                  IconButton(onPressed: onPressed, icon: Icon(Icons.clear)),
                  TextOffWhite(
                    "User",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    BlocProvider.of<AppCubit>(context).getUserData!.userType,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Name",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    BlocProvider.of<AppCubit>(context).getUserData!.firstName +
                        " " +
                        BlocProvider.of<AppCubit>(context)
                            .getUserData!
                            .lastName,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Phone",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    BlocProvider.of<AppCubit>(context).getUserData!.phone,
                    fontSize: SizeManager.size14,
                  ),
                  TextOffWhite(
                    "Email",
                    fontSize: SizeManager.size12,
                  ),
                  TextOffWhite(
                    BlocProvider.of<AppCubit>(context).getUserData!.email!,
                    fontSize: SizeManager.size10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
