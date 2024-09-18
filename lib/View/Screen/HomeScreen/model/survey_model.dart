// To parse this JSON data, do
//
//     final serveyModel = serveyModelFromJson(jsonString);

import 'dart:convert';

ServeyModel serveyModelFromJson(String str) =>
    ServeyModel.fromJson(json.decode(str));

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
            : List<SurveyDatum>.from(
                json["data"]!.map((x) => SurveyDatum.fromJson(x))),
        lastPage: json["last_page"],
      );
}

class SurveyDatum {
  int? id;
  int? userId;
  int? projectId;
  String? surveyName;
  String? emojiOrStar;
  String? repeatStatus;
  String? color;

  User? user;

  SurveyDatum({
    this.id,
    this.userId,
    this.projectId,
    this.surveyName,
    this.emojiOrStar,
    this.repeatStatus,
    this.color,
    this.user,
  });

  factory SurveyDatum.fromJson(Map<String, dynamic> json) => SurveyDatum(
        id: json["id"],
        userId: json["user_id"],
        projectId: json["project_id"],
        surveyName: json["survey_name"],
        emojiOrStar: json["emoji_or_star"],
        repeatStatus: json["repeat_status"],
        color: json["color"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        image: json["image"] ?? "",
      );
}
