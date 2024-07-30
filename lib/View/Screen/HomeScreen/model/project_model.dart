// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  int? currentPage;
  List<Datum>? data;

  int? lastPage;

  ProjectModel({
    this.currentPage,
    this.data,
    this.lastPage,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  int? companyId;
  int? userId;
  List<int>? projectIds;
  String? status;
  List<ProjectDatum>? projects;
  Company? company;

  Datum({
    this.id,
    this.companyId,
    this.userId,
    this.projectIds,
    this.status,
    this.projects,
    this.company,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        projectIds: json["project_ids"] == null
            ? []
            : List<int>.from(json["project_ids"]!.map((x) => x)),
        status: json["status"],
        projects: json["projects"] == null
            ? []
            : List<ProjectDatum>.from(
                json["projects"]!.map((x) => ProjectDatum.fromJson(x))),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "project_ids": projectIds == null
            ? []
            : List<dynamic>.from(projectIds!.map((x) => x)),
        "status": status,
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "company": company?.toJson(),
      };
}

class Company {
  int? id;
  String? name;
  String? email;
  String? companyId;
  dynamic image;

  dynamic address;
  dynamic phoneNumber;

  String? roleType;

  Company({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
    this.roleType,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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

class ProjectDatum {
  int? id;
  int? userId;
  String? projectName;

  ProjectDatum({
    this.id,
    this.userId,
    this.projectName,
  });

  factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["id"],
        userId: json["user_id"],
        projectName: json["project_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "project_name": projectName,
      };
}
