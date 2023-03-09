import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GuestTile extends StatelessWidget {
  final GuestModel? guestModel;

  const GuestTile({Key? key,required this.guestModel}) : super(key: key);

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
          title: TextBlue(guestModel!.guestData.firstName +
              " " +
              guestModel!.guestData.lastName),
          subtitle: TextBlue(guestModel!.guestData.peopleCount.toString()),
          trailing:
              TextBlue(guestModel!.isConfirmed ? "Confirmed" : "Un Confirmed"),
        ),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (c) {},
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (c) {},
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
      ),
    );
  }
}
