import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/values/colors_value.dart';
import 'package:jira_mobile/values/http_link..dart';
import 'package:katana_indicator/katana_indicator.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/data_fetcher.dart';
import '../models/transaction.dart';
import '../values/share_keys.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selected_date = DateTime.now();
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  Map<String, String> popInfo = {
    "totalBalanced": "...",
    "income": "...",
    "expense": "..."
  };
  List<Transaction> listTrans = [];
  String? current_acc_id = "";
  Map<String,String> listSpendPicture = {
    "coffee": HTTPValue.coffee_img,
    "accomodation":HTTPValue.accomodation_img,
    "food":HTTPValue.food_img,
    "transport":HTTPValue.transport_img,
    "other":HTTPValue.other_img,
    "entertainment":HTTPValue.entertainment_img,
  };



  Future<void> getAccountInfo() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.dart_green,),
          );
        });
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      current_acc_id = prefs.getString(AppKey.AccountID);
    });
    final tmp = await DataFetcher.fetchPopularInfo(current_acc_id,
            selected_date.month.toString(), selected_date.year.toString())
        .then((value) => value);
    setState(() {
      popInfo = tmp;
    });
    Navigator.of(context).pop();
  }

  Future<void> getTransactionList() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.dart_green,),
          );
        });

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      current_acc_id = prefs.getString(AppKey.AccountID);
    });
    List<Transaction> tmp = await DataFetcher.fetchTransaction(current_acc_id,
            selected_date.month.toString(), selected_date.year.toString())
        .then((value) => value);
    setState(() {
      listTrans = tmp;
    });

    Navigator.of(context).pop();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAccountInfo().then((value) {
        getTransactionList();
      });
    });
  }

  String total = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    months[selected_date.month - 1],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showMonthPicker(
                      headerColor: AppColor.dart_green,
                      selectedMonthBackgroundColor: AppColor.dart_green,
                      unselectedMonthTextColor: Colors.black,
                      customHeight: 240,
                      context: context,
                      initialDate: DateTime.now(),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          selected_date = date;
                          getAccountInfo().then((value) {
                            getTransactionList();
                          });
                        });
                      }
                    });
                  },
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 120, left: 20, right: 20),
            height: 180,
            decoration: BoxDecoration(
              color: AppColor.dart_green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5, left: 10, bottom: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\$${popInfo["totalBalanced"]}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 26),
                    )),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_circle_down,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Income",
                                    style: TextStyle(color: Colors.white38),
                                  )
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: Text("\$${popInfo["income"]}",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.arrow_circle_up,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Expenses",
                                    style: TextStyle(color: Colors.white38),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                child: Text("\$${popInfo["expense"]}",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, left: 30),
            child: Text(
              'Transactions History',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Container(
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listTrans.length,
                  itemBuilder: (context, index) {
                    return (Trans(
                        http_img: listSpendPicture[listTrans[index].cost_type]??"",
                        type: listTrans[index].type?? "",
                        name: listTrans[index].text ?? "",
                        date: listTrans[index].date.toString().substring(
                            0, listTrans[index].date.toString().indexOf(" ")),
                        price: "\$${listTrans[index].cost.toString()}"));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class Trans extends StatelessWidget {
  final String http_img;
  final String type;
  final String name;
  final String date;
  final String price;
  const Trans(
      {super.key,
      required this.http_img,
      required this.type,
      required this.name,
      required this.date,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                child: Image.network(this.http_img),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 4),
                child: Text(
                  this.date,
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              )
            ]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text( (this.type=="Income"?"+ ${this.price}":"- ${this.price}"), style: TextStyle(color: this.type=="Expense"?Color.fromARGB(228, 212, 42, 42):Colors.black),),
          ),
        )
      ]),
    );
  }
}
