import 'package:elmotatawera_events/data/constant/color_manager.dart';
import 'package:elmotatawera_events/data/constant/size_manager.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final void Function()? onPressed;

  const CustomAppBar({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: SizeManager.size16),
              decoration: BoxDecoration(
                  color: ColorManager.terkwazColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeManager.size20),
                    bottomRight: Radius.circular(SizeManager.size20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  GlobalRichText(
                    firstString: "El Motatawera ",
                    secondString: "Events",
                    secondTextColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeManager.size22,
            ),
          ],
        ),
      ],
    );
  }
}
