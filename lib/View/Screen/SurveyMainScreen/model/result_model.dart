// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  String? projectName;
  String? surveyName;
  String? emojiOrStar;

  int? totalQuestions;

  List<ResultDatum>? answers;

  ResultModel(
      {this.projectName,
      this.surveyName,
      this.totalQuestions,
      this.answers,
      this.emojiOrStar});

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        projectName: json["project_name"],
        surveyName: json["survey_name"],
        totalQuestions: json["total_questions"],
        emojiOrStar: json["emoji_or_star"],
        answers: json["answers"] == null
            ? []
            : List<ResultDatum>.from(
                json["answers"]!.map((x) => ResultDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "project_name": projectName,
        "survey_name": surveyName,
        "total_questions": totalQuestions,
        "emoji_or_star": emojiOrStar,
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
      };
}

class ResultDatum {
  int? id;
  int? surveyId;
  int? userId;
  int? questionId;
  String? answer;
  String? comment;
  Question? question;

  ResultDatum({
    this.id,
    this.surveyId,
    this.userId,
    this.questionId,
    this.answer,
    this.comment,
    this.question,
  });

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
        id: json["id"],
        surveyId: json["survey_id"],
        userId: json["user_id"],
        questionId: json["question_id"],
        answer: json["answer"],
        comment: json["comment"],
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_id": surveyId,
        "user_id": userId,
        "question_id": questionId,
        "answer": answer,
        "comment": comment,
        "question": question?.toJson(),
      };
}

class Question {
  int? id;
  int? userId;
  int? projectId;
  int? surveyId;
  String? questionEn;
  dynamic questionJer;
  int? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Question({
    this.id,
    this.userId,
    this.projectId,
    this.surveyId,
    this.questionEn,
    this.questionJer,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        userId: json["user_id"],
        projectId: json["project_id"],
        surveyId: json["survey_id"],
        questionEn: json["question_en"],
        questionJer: json["question_jer"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "project_id": projectId,
        "survey_id": surveyId,
        "question_en": questionEn,
        "question_jer": questionJer,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
