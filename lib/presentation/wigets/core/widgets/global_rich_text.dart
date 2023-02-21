import 'package:flutter/material.dart';

class GlobalRichText extends StatelessWidget {
  final String? firstString;
  final String? secondString;

  const GlobalRichText({
    Key? key,
    this.firstString,
    this.secondString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstString,
        children: [
          TextSpan(text: secondString),
        ],
      ),
    );
  }
}
