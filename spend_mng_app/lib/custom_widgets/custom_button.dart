import 'package:flutter/material.dart';

class CustomButtonView extends StatelessWidget {
  final String title;
  const CustomButtonView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 72, 121, 142),
              Color.fromARGB(116, 45, 143, 208),
            ])),
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ));
  }
}
