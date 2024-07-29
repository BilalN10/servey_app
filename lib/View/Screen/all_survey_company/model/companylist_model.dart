// To parse this JSON data, do
//
//     final companyList = companyListFromJson(jsonString);

import 'dart:convert';

CompanyList companyListFromJson(String str) =>
    CompanyList.fromJson(json.decode(str));

String companyListToJson(CompanyList data) => json.encode(data.toJson());

class CompanyList {
  int? currentPage;
  List<CompanyDatum>? data;

  int? from;
  int? lastPage;

  CompanyList({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<CompanyDatum>.from(
                json["data"]!.map((x) => CompanyDatum.fromJson(x))),
        from: json["from"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "from": from,
        "last_page": lastPage,
      };
}

class CompanyDatum {
  int? id;
  String? name;
  String? email;
  String? companyId;
  String? image;

  String? address;
  String? phoneNumber;

  String? status;

  CompanyDatum({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
    this.status,
  });

  factory CompanyDatum.fromJson(Map<String, dynamic> json) => CompanyDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        companyId: json["company_id"],
        image: json["image"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "company_id": companyId,
        "image": image,
        "address": address,
        "phone_number": phoneNumber,
        "status": status,
      };
}
