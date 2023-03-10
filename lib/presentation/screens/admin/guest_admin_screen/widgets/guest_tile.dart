import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class GuestTile extends StatelessWidget {
  final GuestModel? guestModel;
  final Function(BuildContext)? onPressedDelete;
  final Function(BuildContext)? onPressedUpdate;

  const GuestTile({Key? key, required this.guestModel,this.onPressedDelete,this.onPressedUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Slidable(
        child: ListTile(
          onTap: () {
            BlocProvider.of<AppCubit>(context)
                .getSelectedQrInvition(guestModel!);
            Navigator.pushNamed(context, RouteNameManager.inviteScreen);
          },
          title: Text(guestModel!.guestData.firstName +
              " " +
              guestModel!.guestData.lastName,
            style: GoogleFonts.poppins(
                fontSize: SizeManager.size12,
                color: ColorManager.deepBlue),),
          subtitle: Text("Count "+guestModel!.guestData.peopleCount.toString(),
            style: GoogleFonts.poppins(
                fontSize: SizeManager.size12,
                color: ColorManager.deepBlue),),
          trailing: guestModel!.isConfirmed
              ? Text(
                  "Confirmed",
                  style: GoogleFonts.poppins(
                      fontSize: SizeManager.size12,
                      color: ColorManager.greenColor),
                )
              : Text(
                  "Un Confirmed",
                  style: GoogleFonts.poppins(
                      fontSize: SizeManager.size12,
                      color: ColorManager.errorColor),
                ),
        ),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context){
                BlocProvider.of<AppCubit>(context).deleteGuest(guestModel!);
              },
              backgroundColor: ColorManager.errorColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context){
                guestModel!.isConfirmed=!guestModel!.isConfirmed;
                BlocProvider.of<AppCubit>(context).updateGuestData(guestModel!);
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.update,
              label:guestModel!.isConfirmed? 'un Confirmed':"Confirmed",
            ),
          ],
        ),
      ),
    );
  }
}
