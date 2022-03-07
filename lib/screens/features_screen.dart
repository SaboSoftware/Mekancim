import 'package:flutter/material.dart';

class FeaturesScreen extends StatefulWidget {
  @override
  _FeaturesScreenState createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  TextEditingController textController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarTheme.of(context).backgroundColor,
          elevation: 0.5,
          flexibleSpace: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: new InputDecoration.collapsed(
                        hintText: 'Ara',
                      ),
                      controller: textController,
                      onSubmitted: (value) {
                        setState(() {
                          textController.text = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: Center(
            child: Text(textController.text),
          ),
        ),
      ),
    );
  }
}
