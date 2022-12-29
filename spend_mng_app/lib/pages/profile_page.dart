import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jira_mobile/pages/change_password_page.dart';
import 'package:jira_mobile/values/colors_value.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200, bottom: 5),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: AssetImage('assets/img/profile.png')),
                  shape: BoxShape.circle),
            ),
            Container(
              margin: EdgeInsets.all(2),
              child: Text(
                'Enjelin Morgeana',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  '@enjelin_morgeana',
                  style: TextStyle(color: AppColor.main_color),
                )),
          ],
        ),
      ),
      Flexible(
        child: Container(
          height: 1000,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              //Line(ic: Icons.account_circle, text: 'Personal infomation'),
              // Line(
              //   ic: Icons.facebook,
              //   text: "Author contact info",
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ChangePasswordPage()));
              //   },
              // ),
              Line(
                ic: Icons.password,
                text: 'Change password',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordPage()));
                },
              )
              //Line(ic: Icons.logout, text: 'Log out'),
            ],
          ),
        ),
      ),
    ]);
  }
}

class Line extends StatelessWidget {
  final void Function() onTap;
  final IconData ic;
  final String text;
  const Line(
      {super.key, required this.ic, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20),
        height: 60,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              child: Icon(
                this.ic,
                size: 40,
              ),
            ),
            Text(this.text)
          ],
        ),
      ),
    );
  }
}
