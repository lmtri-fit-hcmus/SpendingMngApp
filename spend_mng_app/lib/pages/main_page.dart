import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/pages/home_page.dart';
import 'package:jira_mobile/pages/profile_page.dart';
import 'package:jira_mobile/values/colors_value.dart';
import 'package:jira_mobile/values/share_keys.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton.extended(
            onPressed: () {},
            isExtended: true,
            backgroundColor: AppColor.dart_green,
            shape: CircleBorder(),
            label: Icon(Icons.add,size: 40,),
            
          ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Stack(
          children: <Widget>[
            Container(
            height: 250,
            child: AppBar(
            backgroundColor: AppColor.main_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(180,60),
          ),
              )),
      ),
            Container(
              child: _widgetOptions.elementAt(_selectedIndex)),]),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.dart_green,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
