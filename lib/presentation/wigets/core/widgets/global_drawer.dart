import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  void Function()? onPressed;

  GlobalDrawer({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 200,
        child: Column(
          children: [
            // DrawerHeader(child: child)
            Expanded(
              child: ListView(
                children: [
                  IconButton(onPressed: onPressed, icon: Icon(Icons.clear)),
                  ListTile(
                    title: Text("data"),
                  ),
                  ListTile(
                    title: Text("data"),
                  ),
                  ListTile(
                    title: Text("data"),
                  ),
                  ListTile(
                    title: Text("data"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
