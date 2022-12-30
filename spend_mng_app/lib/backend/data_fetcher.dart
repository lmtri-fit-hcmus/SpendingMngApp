import 'dart:convert';
import 'package:intl/intl.dart';
import "package:mongo_dart/mongo_dart.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jira_mobile/models/account_info.dart';
import 'package:http/http.dart' as http;

class DataFetcher {
  static final oCcy = new NumberFormat("#,##0.00", "en_US");
  static const String server =
      "mongodb+srv://lmtri:leminhtri@mng-spending-app.bkbglht.mongodb.net/spnd_mng";
  static var db = null;
  static var data = null;
  static Future<DbCollection> LoadServer() async {
    if (db == null) {
      db = await Db.create(server);
      await db.open();
      data = db.collection('data');
    }
    return data;
  }

  static Future<Map<String, String>> fetchPopularInfo(
      String? srcAccountId) async {
    Map<String, String> res = {};
    var value = await LoadServer().then((value) => value);
    await value.find().forEach((element) {
      print(element);
      if (element["accountId"] == srcAccountId) {
        res.addAll({
          "totalBalanced": oCcy.format(int.parse(element["totalBalanced"])),
          "income": oCcy.format(int.parse(element["income"])),
          "expense": oCcy.format(int.parse(element["expense"]))
        });
      }
    });
    return res;
  }

  // static Future<List<AccountInfo>> fetchAccoutInfo({int page = 1}) async {
  //   var acc = await LoadServer().then((value) => value);
  //   String body = "[";
  //   int i = 0;
  //   await acc.find().forEach((element) {
  //     String tmp = "{";
  //     tmp += "\"userName\":\"";
  //     tmp += element["userName"];
  //     tmp += "\",\"accountId\":\"";
  //     tmp += element["accountId"];
  //     tmp += "\",\"password\":\"";
  //     tmp += element["password"];
  //     tmp += "\"}";
  //     body += tmp;
  //     body += ",";
  //   });
  //   body = body.substring(0, body.length - 1);
  //   body += ']';
  //   return compute(parseAccountInfo, body);
  // }

  // static Future<void> sendAccountInfor(
  //     String userName, String password, String id) async {
  //   var acc = await LoadServer();
  //   await acc.insert(
  //       {'userName': "$userName", 'password': "$password", 'accountId': "$id"});
  // }

  // static Future<void> changePasswordRequest(
  //     String id, String newPass, List<AccountInfo> list) async {
  //   var acc = await LoadServer();
  //   await acc.updateOne(
  //       where.eq('accountId', id), modify.set('password', newPass));
  // }
}
