import 'dart:convert';

import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_button.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class QRInvititionScreen extends StatelessWidget {
  // String inviteQrCode=;
  @override
  Widget build(BuildContext context) {
    var myCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      body: myCubit.qrSelectedInviteData!.isConfirmed ||
              myCubit.getUserData!.userData.userType !=
                  RouteNameManager.homeGuestScreen
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  child: GlobalRichText(
                    firstString:
                        myCubit.qrSelectedInviteData!.guestData.titleEvent,
                    secondString: " Invitaion",
                  ),
                ),
                TextBlue(
                  "${myCubit.qrSelectedInviteData!.guestData.eventDate.year}/${myCubit.qrSelectedInviteData!.guestData.eventDate.month}/${myCubit.qrSelectedInviteData!.guestData.eventDate.day}",
                  textAlign: TextAlign.center,
                  fontSize: SizeManager.size20,
                  fontWeight: FontWeight.bold,
                ),
                TextBlue(
                  "${myCubit.qrSelectedInviteData!.guestData.eventDate.hour}:${myCubit.qrSelectedInviteData!.guestData.eventDate.minute}",
                  textAlign: TextAlign.center,
                  fontSize: SizeManager.size16,
                  fontWeight: FontWeight.bold,
                ),
                Center(
                  child: PrettyQr(
                    size: 70.w,
                    data: jsonEncode(myCubit.qrSelectedInviteData!.toQrCode()),
                  ),
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeManager.size12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextBlue(
                      "Your Invitation Not Confirmed",
                      fontSize: SizeManager.size12,
                    ),
                    SizedBox(
                      height: SizeManager.size10,
                    ),
                    TextBlue(
                      "If you didn't pay or for another reason",
                      fontSize: SizeManager.size12,
                    ),
                    SizedBox(
                      height: SizeManager.size10,
                    ),
                    CustomButton(
                      text: "Contact With Admin",
                      onTap: () async {
                        if (!await launchUrl(Uri(
                            scheme: 'tel',
                            path: myCubit
                                .qrSelectedInviteData!.guestData.adminPhone))) {
                          throw Exception('Could not launch phone');
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
