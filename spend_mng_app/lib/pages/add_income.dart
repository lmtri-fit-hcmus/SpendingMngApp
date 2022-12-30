import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/custom_widgets/custom_button.dart';
import 'package:jira_mobile/values/colors_value.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
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
                        'Add Income',
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
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30, top: 150),
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
                      child: Text('NAME'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color.fromARGB(255, 90, 87, 87))),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.grey[400])),
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
                                child: Text("Hello lmtr")),
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
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                    InkWell(
                      child: CustomButtonView(title: "Add"),
                      onTap: () {},
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
