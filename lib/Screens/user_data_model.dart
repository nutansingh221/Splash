// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.name = '',
    this.email = '',
  });

  String name;
  String email;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}
