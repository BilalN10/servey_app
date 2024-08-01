// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) => ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
    Data? data;

    ProjectModel({
        this.data,
    });

    factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    int? companyId;
    int? userId;
    List<int>? projectIds;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Projects? projects;
    Company? company;

    Data({
        this.id,
        this.companyId,
        this.userId,
        this.projectIds,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.projects,
        this.company,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        projectIds: json["project_ids"] == null ? [] : List<int>.from(json["project_ids"]!.map((x) => x)),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        projects: json["projects"] == null ? null : Projects.fromJson(json["projects"]),
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "project_ids": projectIds == null ? [] : List<dynamic>.from(projectIds!.map((x) => x)),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "projects": projects?.toJson(),
        "company": company?.toJson(),
    };
}

class Company {
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

    Company({
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

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        companyId: json["company_id"],
        image: json["image"],
        otp: json["otp"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        roleType: json["role_type"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class Projects {
    int? currentPage;
    List<ProjectDatum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Projects({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ProjectDatum>.from(json["data"]!.map((x) => ProjectDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class ProjectDatum {
    int? id;
    int? userId;
    String? projectName;
    DateTime? createdAt;
    DateTime? updatedAt;

    ProjectDatum({
        this.id,
        this.userId,
        this.projectName,
        this.createdAt,
        this.updatedAt,
    });

    factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["id"],
        userId: json["user_id"],
        projectName: json["project_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "project_name": projectName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
