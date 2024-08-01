// To parse this JSON data, do
//
//     final serveyModel = serveyModelFromJson(jsonString);

import 'dart:convert';

ServeyModel serveyModelFromJson(String str) =>
    ServeyModel.fromJson(json.decode(str));

String serveyModelToJson(ServeyModel data) => json.encode(data.toJson());

class ServeyModel {
  int? currentPage;
  List<SurveyDatum>? data;

  int? lastPage;

  ServeyModel({
    this.currentPage,
    this.data,
    this.lastPage,
  });

  factory ServeyModel.fromJson(Map<String, dynamic> json) => ServeyModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<SurveyDatum>.from(json["data"]!.map((x) => SurveyDatum.fromJson(x))),
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

class SurveyDatum {
  int? id;
  int? userId;
  int? projectId;
  String? surveyName;
  String? emojiOrStar;
  String? repeatStatus;
  dynamic archiveStatus;
  User? user;

  SurveyDatum({
    this.id,
    this.userId,
    this.projectId,
    this.surveyName,
    this.emojiOrStar,
    this.repeatStatus,
    this.archiveStatus,
    this.user,
  });

  factory SurveyDatum.fromJson(Map<String, dynamic> json) => SurveyDatum(
        id: json["id"],
        userId: json["user_id"],
        projectId: json["project_id"],
        surveyName: json["survey_name"],
        emojiOrStar: json["emoji_or_star"],
        repeatStatus: json["repeat_status"],
        archiveStatus: json["archive_status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "project_id": projectId,
        "survey_name": surveyName,
        "emoji_or_star": emojiOrStar,
        "repeat_status": repeatStatus,
        "archive_status": archiveStatus,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;

  dynamic image;

  dynamic address;
  dynamic phoneNumber;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.address,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "address": address,
        "phone_number": phoneNumber,
      };
}
