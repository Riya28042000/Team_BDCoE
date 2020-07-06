import 'package:bdcoe/views/contact.dart';
import 'package:bdcoe/views/details.dart';
import 'package:bdcoe/views/events.dart';
import 'package:bdcoe/views/home.dart';
import 'package:bdcoe/views/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {


  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    Details(),
    Services(),
    Home(),
    Events(),
    Contact(),
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.person, size: 30, color: Colors.black),
          Icon(Icons.question_answer, size: 30, color: Colors.black),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(Icons.calendar_today, size: 30, color: Colors.black),
          Icon(
            Icons.call,
            size: 30,
            color: Colors.black,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            
          });
        },
      ),
      body: _children[_currentIndex],
    );
  }
}
