import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/cart.dart';

import 'account.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    CartWidget(),
    AccountWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF28b446),
        unselectedItemColor: Color(0xFF979797),
        onTap: (value) {
          // Respond to item press.
          setState(() => _selectedIndex = value);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Cart'),
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
