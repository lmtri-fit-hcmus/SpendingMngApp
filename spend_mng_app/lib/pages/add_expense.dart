import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/backend/data_fetcher.dart';
import 'package:jira_mobile/custom_widgets/custom_button.dart';
import 'package:jira_mobile/models/transaction.dart';
import 'package:jira_mobile/pages/main_page.dart';
import 'package:jira_mobile/values/colors_value.dart';
import 'package:jira_mobile/values/http_link..dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:shared_preferences/shared_preferences.dart';

import '../values/share_keys.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime selectedDate = DateTime.now();
  String current_text = "";
  String current_expense = "accomodation";
  int current_amount = 0;
  List<Expense> _list_expense = [
    Expense(
        id: "accomodation",
        text: "Accomodation",
        httpImg: HTTPValue.accomodation_img),
    Expense(
        id: "coffee", text: "Coffee & Drink", httpImg: HTTPValue.coffee_img),
    Expense(
        id: "entertainment",
        text: "Entertainment",
        httpImg: HTTPValue.entertainment_img),
    Expense(id: "food", text: "Food", httpImg: HTTPValue.food_img),
    Expense(
        id: "transport", text: "Transport", httpImg: HTTPValue.transport_img),
    Expense(id: "other", text: "Other", httpImg: HTTPValue.other_img),
  ];
  String accountId = "";
  String accId = "";
  x() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accountId = prefs.getString(AppKey.AccountID) ?? "";
      accId = prefs.getString("Object_account_id") ?? "";
    });
  }

  var current_expense_menu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      x();
      current_expense_menu = _list_expense[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                child: Image.asset('assets/img/bkgr.png'),
              ),
              Container(
                child: Image.asset('assets/img/circle.png'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        'Add Expense',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 580,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30, top: 80),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(51, 55, 55, 55),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('TYPE'),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color.fromARGB(255, 90, 87, 87))),
                      child: Container(
                        child: DropdownButton<Expense>(
                          elevation: 10,
                          value: current_expense_menu,
                          onChanged: (Expense? v) {
                            setState(() {
                              current_expense_menu = v ??
                                  Expense(
                                      id: "accomodation",
                                      text: "Accomodation",
                                      httpImg: HTTPValue.accomodation_img);
                              current_expense = v!.id;
                            });
                          },
                          icon: Icon(Icons.arrow_drop_down),
                          items: _list_expense
                              .map<DropdownMenuItem<Expense>>((Expense value) {
                            return DropdownMenuItem<Expense>(
                              value: value,
                              child: value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('NAME'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color.fromARGB(255, 90, 87, 87))),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Expense Name",
                            hintStyle: TextStyle(color: Colors.grey[400])),
                        onChanged: (value) {
                          setState(() {
                            current_text = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text('AMOUNT'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color.fromARGB(255, 90, 87, 87))),
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "\$",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                          onChanged: (value) {
                            setState(() {
                              current_amount = int.parse(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text('DATE'),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 30),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromARGB(255, 90, 87, 87))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(selectedDate.year.toString() +
                                    "-" +
                                    selectedDate.month.toString() +
                                    "-" +
                                    selectedDate.day.toString())),
                            Container(
                              child: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () {
                                  print("ontAP");
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: AppColor.dart_green,
                                              // header background color
                                              onPrimary: Colors
                                                  .black, // header / body text color
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      }).then((value) {
                                    setState(() {
                                      selectedDate = value ?? DateTime.now();
                                    });
                                  });
                                },
                              ),
                            )
                          ],
                        )),
                    InkWell(
                      child: CustomButtonView(title: "Add"),
                      onTap: () {
                        var trans = Transaction(
                            type: "Expense",
                            cost: current_amount,
                            cost_type: current_expense,
                            text: current_text,
                            date: selectedDate);
                        DataFetcher.sendExpense(
                                trans, mg.ObjectId.fromHexString(accId))
                            .then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Expense extends StatelessWidget {
  final String id;
  final String text;
  final String httpImg;
  const Expense(
      {super.key, required this.id, required this.text, required this.httpImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3),
                  width: 40,
                  height: 40,
                  child: Image.network(this.httpImg),
                ),
              ],
            ),
          ),
          Container(
            child: Container(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(this.text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
