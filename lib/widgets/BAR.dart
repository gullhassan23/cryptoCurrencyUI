
import 'package:cryptocurrency/Views/Cash.dart';
import 'package:cryptocurrency/Views/Home.dart';
import 'package:cryptocurrency/Views/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late List<Widget> pages;
  late Home home;

  late FlutterCash flutterCash;
  late Profile profile;
  int currentTabindex = 0;
  @override
  void initState() {
    home = Home();

    flutterCash = FlutterCash();
    profile = Profile();
    pages = [home, flutterCash, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xff222222),
        color: Color(0xff222222),
        // animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabindex = index;
          });
        },
        items: [
          Icon(
            Icons.stairs,
            color: Colors.white,
          ),
          Icon(
            Icons.flutter_dash,
            color: Colors.white,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Colors.white,
          )
        ],
      ),
      body: pages[currentTabindex],
    );
  }
}
