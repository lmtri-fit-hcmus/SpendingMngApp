import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:jira_mobile/models/transaction.dart';
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
  static Future<DbCollection> LoadServer(String collection) async {
    if (db == null) {
      db = await Db.create(server);
      await db.open();
      data = db.collection(collection);
    }
    return data;
  }

  static Future<Map<String, String>> fetchPopularInfo(
      String? srcAccountId, String month, String year) async {
    Map<String, String> res = {};
    if (db != null) {
      db.close();
      db = null;
    }
    var value = await LoadServer("data").then((value) => value);
    await value.find().forEach((element) {
      print(element);
      if (element["accountId"] == srcAccountId) {
        res.addAll({
          "totalBalanced": oCcy.format(int.parse(element["totalBalanced"])),
          "income": oCcy.format(int.parse(element["income"][year][month])),
          "expense": oCcy.format(int.parse(element["expense"][year][month]))
        });
      }
    });
    db.close();
    db = null;
    return res;
  }

  static Future<List<Transaction>> fetchTransaction(
      String? current_acc_id, String string, String string2) async {
    List<Transaction> res = [];
    if (db != null) {
      db.close();
      db = null;
    }
    var value = await LoadServer("account").then((value) => value);
    var listTransId = [];
    await value.find().forEach((element) {
      print(element);
      if (element["accountId"] == current_acc_id) {
        listTransId = element["listTrans"];
      }
    });
    if (db != null) {
      db.close();
      db = null;
    }
    var trans_colection =
        await LoadServer("transaction").then((value) => value);
    var trans_colection_list = await trans_colection.find().toList();
    for (int i = 0; i < listTransId.length; i++) {
      for (int j = 0; j < trans_colection_list.length; j++) {
        if (trans_colection_list[j]["_id"] == listTransId[i] &&
            trans_colection_list[j]["date"].year.toString() == string2 &&
            trans_colection_list[j]["date"].month.toString() == string) {
          res.add(Transaction(
            type: trans_colection_list[j]["type"],
            cost: trans_colection_list[j]["cost"],
            cost_type: trans_colection_list[j]["cost_type"],
            date: trans_colection_list[j]["date"],
            text: trans_colection_list[j]["text"],
          ));
        }
      }
    }
    db.close();
    db = null;
    return res;
  }

  static Future<void> sendExpense(Transaction src, ObjectId accId) async {
    var acc = await LoadServer("transaction");
    ObjectId id = new ObjectId();
    var ObjectToSaved = {
      "_id": id,
      'type': "${src.type}",
      'cost': src.cost,
      'date': src.date,
      'text': "${src.text}",
      'cost_type': "${src.cost_type}",
      'accountId': accId
    };
    await acc.insert(ObjectToSaved);
    db.close();
    db = null;
    DbCollection a = await LoadServer("account");
    await a.find().forEach((element) {
      if (element["_id"] == accId) {
        List<dynamic> tmp = element["listTrans"];
        tmp.add(id);
        a.updateOne(where.eq('_id', accId), modify.set('listTrans', tmp));
      }
    });
  }
}
