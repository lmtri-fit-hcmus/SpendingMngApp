import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/values/colors_value.dart';
import 'package:jira_mobile/values/http_link..dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    '\$2,500,000',
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
                              child: Text("\$1,800,000",
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
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: Text("\$1,800,000",
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
            height: 1000,
            child: ListView(
              shrinkWrap: true,
              children: [
                Trans(
                    http_img: HTTPValue.coffee_img,
                    name: "Starbucks",
                    date: "Today",
                    price: "\$800")
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Trans extends StatelessWidget {
  final String http_img;
  final String name;
  final String date;
  final String price;
  const Trans(
      {super.key,
      required this.http_img,
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
            child: Text(this.price),
          ),
        )
      ]),
    );
  }
}
