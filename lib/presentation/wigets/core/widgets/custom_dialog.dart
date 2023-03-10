import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_deep_blue.dart';
import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_off_white.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  String? onSureText;
  String? title;
  String? description;
  void Function()? onSure;

  CustomDialog({Key? key, this.title, this.description, this.onSure,this.onSureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextDeepBlue(
              title!,
              fontSize: SizeManager.size18,
              textAlign: TextAlign.center,
            ),
            TextDeepBlue(
              description!,
              fontSize: SizeManager.size12,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeManager.size12),
                        color: ColorManager.deepBlue,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeManager.size12,
                        vertical: SizeManager.size8,
                      ),
                      child: TextOffWhite("Cancel"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onSure,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeManager.size12),
                        color: ColorManager.deepBlue,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeManager.size12,
                        vertical: SizeManager.size8,
                      ),
                      child: TextOffWhite(onSureText!),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
