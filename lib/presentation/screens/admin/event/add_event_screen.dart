import 'package:elmotatawera_events/presentation/screens/registration/widget/custom_textformfield.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/global_rich_text.dart';
import 'package:elmotatawera_events/presentation/wigets/core/widgets/pressed_text.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          GlobalRichText(
            firstString: "New",
            secondString: " Event",
          ),

          GlobalPressedText(text: "",onTap: (){

          },),
          CustomTextFormField(
            text: "Title",
          ),CustomTextFormField(
            text: "location",
          ),CustomTextFormField(
            text: "location url",
          ),CustomTextFormField(
            text: "price",
          ),CustomTextFormField(
            text: "Title",
          ),CustomTextFormField(
            text: "Title",
          ),

        ],
      ),
    );
  }
}
