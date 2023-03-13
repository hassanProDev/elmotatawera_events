import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/event_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_terkwaz.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class AdminActivityItem extends StatelessWidget {

  final VoidCallback? onTap;
  final EventModel? eventModel;

  const AdminActivityItem({
    Key? key,
    this.onTap,
    this.eventModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: InkWell(
        onTap:onTap,
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.sp)),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                eventModel?.eventData.img!=null?Container(height: 20.h,
                  child: ClipRRect(
                    child: Image.asset(
                      eventModel!.eventData.img!,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.sp),
                      topLeft: Radius.circular(16.sp),
                    ),
                  ),
                ):SizedBox(),
                ListTile(
                  title: TextBlue(eventModel!.eventData.title ?? "title",fontSize: SizeManager.size16,),
                  subtitle: TextDeepBlue("location ${eventModel!.eventData.location}"),
                  trailing: TextTerkwaz("price ${eventModel!.eventData.price}"),
                )
              ],
            ),
          ),
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
                      title: "you will delete this event",
                      description: "make sure you can't get this data again",
                      onSureText: "Delete",
                      onSure: (){
                        BlocProvider.of<AppCubit>(context)
                            .deleteEvent(eventModel!);
                        Navigator.pop(context);
                      },
                    );
                  });

            },
            backgroundColor: ColorManager.errorColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
    );
  }
}
