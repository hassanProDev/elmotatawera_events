

import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 SafeArea(
      child: Container(
        width: 200,
        child: Column(
          children: [
            // DrawerHeader(child: child)
            Expanded(
              child: ListView(
                children: [
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
