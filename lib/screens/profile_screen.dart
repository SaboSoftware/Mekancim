import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mekancimapp/widgets/post_item.dart';

class ProfileScreen extends StatelessWidget {
  Widget profileStatus(String statusName, String value) {
    return Column(
      children: [
        Center(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          statusName,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
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
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg'),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 60,
                          left: 70,
                          child: CircleAvatar(
                            foregroundColor: Colors.blue,
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              iconSize: 15,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    profileStatus('Gönderi', '1'),
                    profileStatus('Takipçi', '10'),
                    profileStatus('Takip Edilen', '100'),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      'Hüseyin Ablay',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          border: Border.all(color: Colors.blue[200], width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Your Posts',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.blue,
                  thickness: 1,
                ),
              ),
              Container(
                child: PostItem(),
                height: 400,
              ),
              Row(
                children: [Text('end of page')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
