import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/users_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final UserModel? userModel;

  // final Function(BuildContext)? onPressedDelete;
  // final Function(BuildContext)? onPressedUpdate;

  const UserTile({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Slidable(
        child: ListTile(
          onTap: () {
            BlocProvider.of<AppCubit>(context)
                .getSelectedUser(userModel!);
            Navigator.pushNamed(context, RouteNameManager.inviteScreen);
          },
          title: Text(
            userModel!.userData.firstName +" "+userModel!.userData.lastName,
            style: GoogleFonts.poppins(
                fontSize: SizeManager.size12, color: ColorManager.deepBlue),
          ),
          subtitle: Text(
            userModel!.isBanded
                ? userModel!.userData.userType:userModel!.userData.email,
            style: GoogleFonts.poppins(
                fontSize: SizeManager.size12, color: ColorManager.deepBlue),
          ),
          trailing: userModel!.isBanded
              ? Text(
                  "Blocked ${userModel!.userData.email}",
                  style: GoogleFonts.poppins(
                      fontSize: SizeManager.size12,
                      color: ColorManager.errorColor),
                )
              : Text(
                  "Active ${userModel!.userData.userType}",
                  style: GoogleFonts.poppins(
                      fontSize: SizeManager.size12,
                      color: ColorManager.greenColor),
                ),
        ),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                 showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            title: "you will ${userModel!.isBanded?'Active':"Block"} this ${userModel!.userData.userType}",
                            // description: "this event is paid you will lose your money",
                            onSureText: userModel!.isBanded?'Active':"Block",
                            onSure: (){
                              BlocProvider.of<AppCubit>(context)
                                  .banUser(userModel!);
                              Navigator.pop(context);
                            },
                          );
                        });
              },
              backgroundColor: userModel!.isBanded?ColorManager.greenColor:ColorManager.errorColor,
              foregroundColor: Colors.white,
              icon: userModel!.isBanded?Icons.accessibility:Icons.block,
              label: userModel!.isBanded?'Active':"Block",
            ),
            // SlidableAction(
            //   onPressed: (context) {
            //     guestModel!.isConfirmed = !guestModel!.isConfirmed;
            //     BlocProvider.of<AppCubit>(context).updateGuestData(guestModel!);
            //   },
            //   backgroundColor: Color(0xFF21B7CA),
            //   foregroundColor: Colors.white,
            //   icon: Icons.update,
            //   label:"Update",
            // ),
          ],
        ),
      ),
    );
  }
}
