import 'package:flutter/material.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    PostHomeScreen(),
    FeaturesScreen(),
    PostAddScreen(),
    MessagesScreen(),
    //  ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      body: _screens[_selectedIndex],
    );
  }

  Widget buildBottomBar() {
    return ConvexAppBar(
      style: TabStyle.custom,
      backgroundColor: Colors.blue,
      color: Colors.white,
      activeColor: Colors.blue,
      height: 50, elevation: 5,
      items: [
        TabItem(
            icon: Icon(Icons.home, size: 30, color: Colors.white),
            title: 'Ana Sayfa'),
        TabItem(
          icon: Icon(Icons.map_outlined, size: 30, color: Colors.white),
          title: 'Harita',
        ),
        TabItem(
          icon: Icon(Icons.add, size: 30, color: Colors.white),
          title: 'Ekle',
        ),

        TabItem(
            icon: Icon(Icons.message, size: 30, color: Colors.white),
            title: 'Mesajlar'),
        // TabItem(
        //   icon: Icon(Icons.person, size: 30, color: Colors.white),
        //   title: 'Profil',
        // ),
      ],
      initialActiveIndex: _selectedIndex, //optional, default as 0
      onTap: _onItemTapped,
    );
  }
}
