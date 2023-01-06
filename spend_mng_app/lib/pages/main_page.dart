import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:jira_mobile/pages/add_expense.dart';
import 'package:jira_mobile/pages/add_income.dart';
import 'package:jira_mobile/pages/chart_page.dart';
import 'package:jira_mobile/pages/home_page.dart';
import 'package:jira_mobile/pages/profile_page.dart';
import 'package:jira_mobile/values/colors_value.dart';
import 'package:jira_mobile/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool _load = false;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChartPage(),
    Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddIncome()));
              }, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.account_balance), // icon
                  Text("Income"), // text
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpense(),
                  ),
                );
              }, // button pressed
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
          child: Image.asset('assets/img/bkgr.png'),
        ),
        Container(
          child: Image.asset('assets/img/circle.png'),
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
