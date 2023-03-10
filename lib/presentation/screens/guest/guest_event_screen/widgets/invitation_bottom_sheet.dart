import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/guest_model.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

invitationBottomSheet(BuildContext context, GuestModel guestModel,
    {int maxGuest = 1}) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) {
        guestModel.guestData.peopleCount = 1;
        return Container(
          decoration: BoxDecoration(
            color: ColorManager.offWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeManager.size12),
                topRight: Radius.circular(SizeManager.size12)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeManager.size16,
              horizontal: SizeManager.size12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(elevation: 5,
                          child: IconButton(
                            onPressed: () {
                              if (AppCubit().guestCount > 1) {
                                AppCubit().changeGuestCounter(AppCubit().guestCount--);
                              }
                            },
                            icon: TextDeepBlue(
                              "-",
                              fontSize: SizeManager.size14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeManager.size10,
                        ),
                        TextDeepBlue(
                          guestModel.guestData.peopleCount.toString(),
                          fontSize: SizeManager.size12,
                        ),
                        SizedBox(
                          width: SizeManager.size10,
                        ),
                        Card(elevation: 5,
                          child: IconButton(
                            onPressed: () {
                              if (AppCubit().guestCount <
                                  maxGuest) {
                                AppCubit().changeGuestCounter(AppCubit().guestCount++);

                              }
                            },
                            icon: TextDeepBlue(
                              "+",
                              fontSize: SizeManager.size14,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: SizeManager.size16,
                ),
                CustomButton(
                  text: "Request an Invite",
                  onTap: () {
                    BlocProvider.of<AppCubit>(context).addGuest(guestModel);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      });
}
