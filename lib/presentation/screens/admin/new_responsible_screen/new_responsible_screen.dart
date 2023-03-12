import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewResponsibleScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return C0ntainer(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Add New Security",
                onTap: () {
                  Navigator.pushNamed(context, RouteNameManager.addSecurityScreen);
                },
              ),
              SizedBox(height: 24.sp,),
              CustomButton(
                text: "Add New Admin",
                onTap: () {
                  Navigator.pushNamed(context, RouteNameManager.addAdminScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
