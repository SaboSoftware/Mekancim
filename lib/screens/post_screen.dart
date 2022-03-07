import 'package:flutter/material.dart';
import 'package:mekancimapp/widgets/post_item.dart';

class PostHomeScreen extends StatefulWidget {
  final routename = '/postscreen';
  @override
  _PostHomeScreenState createState() => _PostHomeScreenState();
}

class _PostHomeScreenState extends State<PostHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarTheme.of(context).backgroundColor,
        elevation: 0.5,
        title: Text(
          "mekancim",
          style: TextStyle(fontFamily: 'Cocon', color: Colors.blue),
        ),
        //centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.search), color: Colors.black, onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/profilescreen");
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg'),
              ),
            ),
          ),
        ],
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(15),
        //   ),
        // ),
      ),
      body: PostItem(),
    );
  }
}
