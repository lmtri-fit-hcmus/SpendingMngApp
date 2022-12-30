import 'package:flutter/material.dart';

class CustomButtonView extends StatelessWidget {
  final String title;
  const CustomButtonView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 66, 173, 169),
              Color.fromARGB(116, 23, 130, 105),
            ])),
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ));
  }
}
