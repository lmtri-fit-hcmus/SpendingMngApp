class AccountInfo {
  String? accountId;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  

  AccountInfo({this.accountId, this.userName, this.password});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    userName = json['userName'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    
    return data;
  }
}