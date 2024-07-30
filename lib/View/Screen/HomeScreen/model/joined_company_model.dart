// To parse this JSON data, do
//
//     final joinedCompanyModel = joinedCompanyModelFromJson(jsonString);

import 'dart:convert';

JoinedCompanyModel joinedCompanyModelFromJson(String str) =>
    JoinedCompanyModel.fromJson(json.decode(str));

String joinedCompanyModelToJson(JoinedCompanyModel data) =>
    json.encode(data.toJson());

class JoinedCompanyModel {
  int? currentPage;
  List<JoinedCompanyDatum>? data;
  int? lastPage;

  JoinedCompanyModel({
    this.currentPage,
    this.data,
    this.lastPage,
  });

  factory JoinedCompanyModel.fromJson(Map<String, dynamic> json) =>
      JoinedCompanyModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<JoinedCompanyDatum>.from(json["data"]!.map((x) => JoinedCompanyDatum.fromJson(x))),
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_page": lastPage,
      };
}

class JoinedCompanyDatum {
  int? id;
  int? userId;
  int? companyId;
  String? status;

  User? user;

  JoinedCompanyDatum({
    this.id,
    this.userId,
    this.companyId,
    this.status,
    this.user,
  });

  factory JoinedCompanyDatum.fromJson(Map<String, dynamic> json) => JoinedCompanyDatum(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "status": status,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? companyId;
  String? image;

  dynamic address;
  dynamic phoneNumber;

  User({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        companyId: json["company_id"],
        image: json["image"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "company_id": companyId,
        "image": image,
        "address": address,
        "phone_number": phoneNumber,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
