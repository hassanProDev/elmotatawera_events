import 'package:elmotatawera_events/presentation/wigets/core/app_text/text_blue.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final String? text;
  final IconData? iconData;

  const CustomIconButton({Key? key, this.onTap, this.iconData, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          TextBlue(text ?? ""),
        ],
      ),
    );
  }
}
