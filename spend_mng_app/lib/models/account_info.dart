import 'package:mongo_dart/mongo_dart.dart';

class AccountInfo {
  ObjectId? id;
  String? accountId;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  

  AccountInfo({this.accountId, this.userName, this.password});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    id = ObjectId.fromHexString(json["_id"]);
    accountId = json['accountId'];
    userName = json['userName'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data['accountId'] = this.accountId;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    
    return data;
  }
}