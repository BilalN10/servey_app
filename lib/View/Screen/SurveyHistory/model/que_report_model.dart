class QuestionSurveyModel {
  Question? question;
  OptionPercentage? optionPercentages;

  QuestionSurveyModel({
    this.question,
    this.optionPercentages,
  });

  factory QuestionSurveyModel.fromJson(Map<String, dynamic> json) =>
      QuestionSurveyModel(
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
        optionPercentages: json["option_percentages"] == null
            ? null
            : OptionPercentage.fromJson(json["option_percentages"]),
      );
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
  User? user;

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
    this.user,
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );
}

class User {
  int? id;
  String? name;
  String? email;
  String? companyId;
  dynamic image;
  String? otp;
  dynamic address;
  dynamic phoneNumber;
  DateTime? emailVerifiedAt;
  String? roleType;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.otp,
    this.address,
    this.phoneNumber,
    this.emailVerifiedAt,
    this.roleType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        companyId: json["company_id"],
        image: json["image"],
        otp: json["otp"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        roleType: json["role_type"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "company_id": companyId,
        "image": image,
        "otp": otp,
        "address": address,
        "phone_number": phoneNumber,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "role_type": roleType,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OptionPercentage {
  int? one;
  int? two;
  int? three;
  int? four;
  int? five;

  OptionPercentage({this.one, this.two, this.three, this.four, this.five});

  factory OptionPercentage.fromJson(Map<String, dynamic> json) =>
      OptionPercentage(
        one: json["1"],
        two: json["2"],
        three: json["3"],
        four: json["4"],
        five: json["5"],
      );
}
