import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box_outlined,
              size: 25,
            ),
            onPressed: () {},
            color: Colors.black,
          )
        ],
        elevation: 0.5,
        backgroundColor: AppBarTheme.of(context).backgroundColor,
        title: Text(
          'xhuseyin_',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(),
    );
  }
}
