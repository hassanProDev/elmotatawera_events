import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? currentUser;
  final String? messageUser;
  final String? textMessage;

  const MessageBubble({this.currentUser, this.messageUser, this.textMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: currentUser == messageUser
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: currentUser == messageUser
              ? ColorManager.blueColor
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeManager.size10),
            topRight: Radius.circular(SizeManager.size10),
            bottomLeft: Radius.circular(
                currentUser != messageUser ? SizeManager.size10 : 0),
            bottomRight: Radius.circular(
                currentUser == messageUser ? SizeManager.size10 : 0),
          ),
        ),
        child: currentUser == messageUser
            ? TextOffWhite(textMessage!)
            : TextBlue(textMessage!),
      ),
    );
  }
}
