import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:jira_mobile/pages/chart_page.dart';
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
    ChartPage(),
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
      floatingActionButton: ExpandableFab(
          closeButtonStyle: ExpandableFabCloseButtonStyle(
              backgroundColor: AppColor.dart_green),
          backgroundColor: AppColor.dart_green,
          distance: 100.0,
          child: Icon(Icons.add),
          children: [
            InkWell(
              // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.account_balance), // icon
                  Text("Income"), // text
                ],
              ),
            ),
            InkWell(
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.account_balance_wallet), // icon
                  Text("Expense"), // text
                ],
              ),
            ),
          ]),
      floatingActionButtonLocation: ExpandableFab.location,
      extendBodyBehindAppBar: false,
      extendBody: true,
      body: Stack(children: <Widget>[
        Container(
          height: 250,
          child: AppBar(
              backgroundColor: AppColor.main_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(180, 60),
                ),
              )),
        ),
        Container(child: _widgetOptions.elementAt(_selectedIndex)),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
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
