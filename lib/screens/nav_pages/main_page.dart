import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/screens/nav_pages/HomePage.dart';
import 'package:flutter_crud_fb/screens/nav_pages/my_questions.dart';

import '../contacts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List Pages = [HomePage(), Contacts()];

  int curIdx = 0;
  void onTap(int index) {
    setState(() {
      curIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Pages[curIdx],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff3c413f),
          onTap: onTap,
          currentIndex: curIdx,
          selectedFontSize: 12,
          unselectedFontSize: 0,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.task_rounded), label: 'My Questions')
          ]),
    );
  }
}
