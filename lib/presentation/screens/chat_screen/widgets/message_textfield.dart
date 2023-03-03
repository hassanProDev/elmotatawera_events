import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key,this.controller,this.onTap}) : super(key: key);
  final TextEditingController? controller;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
          suffixIcon: InkWell(
            onTap:(){
              onTap!();
            },
            child: Icon(Icons.send),
          ),
          hintText: "type your message"),
      controller: controller,
    );
  }
}
