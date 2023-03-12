import 'package:elmotatawera_events/bussiness_logic/cubit/app_cubit.dart';
import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/model/message_model.dart';
import 'package:elmotatawera_events/presentation/screens/chat_screen/widgets/message_bubble.dart';
import 'package:elmotatawera_events/presentation/screens/chat_screen/widgets/message_textfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/custom_container_widget.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "chatScreen";
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
                              textMessage:
                                  myCubit.allMessages[index].messageData.message,
                            )),
                  ),
                  MessageTextField(
                    controller: message,
                    onTap: () async {
                      if (message.text == null || message.text.isEmpty) {
                        return;
                      }
                      await myCubit.addMessage(MessageModel(
                        messageData: MessageData(
                            uid: myCubit.getUserData!.uid, message: message.text),
                        docId: myCubit.selectedEventModel!.eventData.docId!,
                      ));
                      if(controller.hasClients){
                        controller.animateTo(0,
                            duration: Duration(milliseconds: 1500),
                            curve: Curves.easeInOutSine);
                      }
                      message.clear();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
