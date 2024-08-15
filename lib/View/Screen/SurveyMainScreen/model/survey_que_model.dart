class QuestionDatum {
  int? id;
  int? userId;
  int? projectId;
  int? surveyId;
  String? questionEn;
  int? comment;
  // User? user;

  QuestionDatum({
    this.id,
    this.userId,
    this.projectId,
    this.surveyId,
    this.questionEn,
    this.comment,
    // this.user,
  });

  factory QuestionDatum.fromJson(Map<String, dynamic> json) => QuestionDatum(
      id: json["id"],
      userId: json["user_id"],
      projectId: json["project_id"],
      surveyId: json["survey_id"],
      questionEn: json["question_en"],
      // user: json["user"] == null ? null : User.fromJson(json["user"]),
      comment: json["comment"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "project_id": projectId,
        "survey_id": surveyId,
        "question_en": questionEn,
        "comment": comment,
        //  "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? companyId;
  dynamic image;
  dynamic address;
  dynamic phoneNumber;
  String? roleType;

  User({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
    this.roleType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        companyId: json["company_id"],
        image: json["image"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        roleType: json["role_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "company_id": companyId,
        "image": image,
        "address": address,
        "phone_number": phoneNumber,
        "role_type": roleType,
      };
}
