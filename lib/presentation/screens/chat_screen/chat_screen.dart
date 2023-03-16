import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/consts.dart';
import 'package:elmotatawera_events/data/constant/route_name_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/data/model/message_model.dart';
import 'package:elmotatawera_events/presentation/screens/chat_screen/widgets/message_bubble.dart';
import 'package:elmotatawera_events/presentation/screens/chat_screen/widgets/message_textfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController message = TextEditingController();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit myCubit = BlocProvider.of(context);
        print(myCubit.allMessages);
        return C0ntainer(
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.blueColor,
                ),
              ),
              backgroundColor: Colors.white,
              title: GlobalRichText(
                firstString: myCubit.selectedEventModel!.eventData.title,
                secondString: " Chat",
              ),
              centerTitle: true,
              actions: [
                myCubit.getUserData!.userData.userType ==
                        RouteNameManager.homeGuestScreen
                    ? Container()
                    : Switch(
                        value: myCubit.appSetting[kIsChatForAll],
                        onChanged: (e) {
                          myCubit.updateChatState(e);
                        })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemCount: myCubit.allMessages.length,
                        itemBuilder: (_, index) => MessageBubble(
                              currentUser: myCubit.getUserData!.uid,
                              messageUser:
                                  myCubit.allMessages[index].messageData.uid,
                              textMessage: myCubit
                                  .allMessages[index].messageData.message,
                            )),
                  ),
                  !myCubit.appSetting[kIsChatForAll] &&
                          myCubit.getUserData!.userData.userType ==
                              RouteNameManager.homeGuestScreen
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          width: double.infinity,
                          color: Colors.white,
                          child: TextDeepBlue(
                            "just admin has access for chat",
                            textAlign: TextAlign.center,
                            fontSize: SizeManager.size12,
                          ),
                        )
                      : MessageTextField(
                          controller: message,
                          onTap: () async {
                            if (message.text == null || message.text.isEmpty) {
                              return;
                            }
                            await myCubit.addMessage(MessageModel(
                              messageData: MessageData(
                                  uid: myCubit.getUserData!.uid,
                                  message: message.text),
                              docId:
                                  myCubit.selectedEventModel!.eventData.docId!,
                            ));
                            if (controller.hasClients) {
                              controller.animateTo(0,
                                  duration: Duration(milliseconds: 1500),
                                  curve: Curves.easeInOutSine);
                            }
                            message.clear();
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
