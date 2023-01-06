import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jira_mobile/custom_widgets/custom_button.dart';
import 'package:jira_mobile/models/account_info.dart';
import 'package:jira_mobile/backend/account_request.dart';
import 'package:jira_mobile/pages/change_password_page.dart';
import 'package:jira_mobile/pages/main_page.dart';
import 'package:jira_mobile/pages/signup_page.dart';
import 'package:jira_mobile/values/share_keys.dart';
import 'package:password_text_field/password_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<AccountInfo> listAccInf = [];
  fetchAccount() {
    Future<List<AccountInfo>> res = AccountRequest.fetchAccoutInfo();
    res.then((dataFromServer) {
      setState(() {
        listAccInf = dataFromServer;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    
    Future<List<AccountInfo>> res = AccountRequest.fetchAccoutInfo();
    res.then((dataFromServer) {
      setState(() {
        listAccInf = dataFromServer;
      });});

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }
  String ObjId = "";
  String userName = "";
  String password = "";
  String errStr = "";

  setPersonalInfo(String _accId, String fn, String ln, String em) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppKey.AccountID, _accId).then((bool success) {});
    prefs.setString("Object_account_id", ObjId).then((bool success) {});
    prefs.setString(AppKey.FirstName, fn).then((bool success) {});
    prefs.setString(AppKey.LastName, ln).then((bool success) {});
    prefs.setString(AppKey.Email, em).then((bool success) {});
    prefs.setBool("isCall", false).then((bool success) {});
  }

  @override
  Widget build(BuildContext context) {
    String invalidUsername = "Inavailable username!";
    String invalidPassword = "Password is not correct!";
    void onFetch() {
      setState(() {
        fetchAccount();
      });
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              child: Image.asset('assets/img/bkgr.png'),
            ),
            Container(
              child: Image.asset('assets/img/circle.png'),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 100,
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(51, 55, 55, 55),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        userName = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: PasswordTextField(
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text(
                              '$errStr',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              int i = 0;
                              for (; i < listAccInf.length; i++) {
                                if (listAccInf[i].userName == userName) {
                                  if (listAccInf[i].password == password) {
                                    setState(() {
                                      ObjId = listAccInf[i].id.toString().replaceAll("ObjectId(\"", "").replaceAll("\")", "");
                                      errStr = "";
                                      setPersonalInfo(
                                          listAccInf[i].accountId ?? "",
                                          listAccInf[i].firstName ?? "",
                                          listAccInf[i].lastName ?? "",
                                          listAccInf[i].email ?? "", );
                                      
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainPage()));
                                    });
                                    break;
                                  } else {
                                    setState(() {
                                      errStr = invalidPassword;
                                    });
                                    break;
                                  }
                                }
                              }
                              if (i == listAccInf.length && errStr == "") {
                                setState(() {
                                  errStr = invalidUsername;
                                });
                              }
                            },
                            child: CustomButtonView(
                              title: "Login",
                            ),
                          ),
                          Container(
                              width: 350,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 2,
                                color: Colors.black,
                              ))),
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text('Don\'t have an account?'))),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage(
                                            onFet: onFetch,
                                            list: listAccInf,
                                          )));
                            },
                            child: CustomButtonView(
                              title: "Create an account",
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
    ;
  }
}
