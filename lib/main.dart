import 'package:flutter/material.dart';
import 'package:mekancimapp/data/data.dart';
import 'package:mekancimapp/models/post.dart';
import 'package:mekancimapp/providers/great_places.dart';
import 'package:mekancimapp/screens/comment_screen.dart';
import 'package:mekancimapp/screens/home_screen.dart';
import 'package:mekancimapp/screens/login_screen.dart';
import 'package:mekancimapp/screens/post_screen.dart';
import 'package:mekancimapp/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Data(),
        ),
        // ChangeNotifierProvider.value(
        //   value: GreatPlaces(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mekancim',
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Color.fromRGBO(247, 247, 247, 1)),
            scaffoldBackgroundColor: Color.fromRGBO(247, 247, 247, 1),
            primarySwatch: Colors.blue,
            bottomAppBarColor: Colors.blue,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.blue,
            )),
        home: LoginScreen(),
        routes: {
          "/anasayfa": (BuildContext context) => HomeScreen(),
          "/profilescreen": (BuildContext context) => ProfileScreen(),
          '/postscreen': (ctx) => PostHomeScreen(),
          '/postoverviewscreen': (ctx) => ViewPostScreen(),
        },
      ),
    );
  }
}
