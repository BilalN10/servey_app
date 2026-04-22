import 'dart:convert';

class ProjectIssueModel {
  final int? id;
  final int projectId;
  final String? system;
  final String? subsystem;
  final String? category;
  final String description;
  final String? descriptionOriginalLanguage;
  final String? reference;
  final String? location;
  final String? recorder;
  final String? recorded;
  final String? responsibleCompany;
  final String? responsibleEmployer;
  final String? deadLine;
  final String? priority;
  final String? status;
  final String? completedOn;
  final String? completedBy;
  final String? dummy1;
  final String? dummy2;
  final String? dummy3;
  final String? dummy4;
  final String? createdAt;
  final String? updatedAt;
  final Project? project;
  final List<Comment>? comments;

  ProjectIssueModel({
    this.id,
    required this.projectId,
    this.system,
    this.subsystem,
    this.category,
    required this.description,
    this.descriptionOriginalLanguage,
    this.reference,
    this.location,
    this.recorder,
    this.recorded,
    this.responsibleCompany,
    this.responsibleEmployer,
    this.deadLine,
    this.priority,
    this.status,
    this.completedOn,
    this.completedBy,
    this.dummy1,
    this.dummy2,
    this.dummy3,
    this.dummy4,
    this.createdAt,
    this.updatedAt,
    this.project,
    this.comments,
  });

  factory ProjectIssueModel.fromJson(Map<String, dynamic> json) {
    return ProjectIssueModel(
      id: json['id'],
      projectId: json['project_id'],
      system: json['system'],
      subsystem: json['subsystem'],
      category: json['category'],
      description: json['description'] ?? '',
      descriptionOriginalLanguage: json['description_original_language'],
      reference: json['reference'],
      location: json['location'],
      recorder: json['recorder'],
      recorded: json['recorded'],
      responsibleCompany: json['responsible_company'],
      responsibleEmployer: json['responsible_employer'],
      deadLine: json['dead_line'],
      priority: json['priority'],
      status: json['status'],
      completedOn: json['completed_on'],
      completedBy: json['completed_by'],
      dummy1: json['dummy1'],
      dummy2: json['dummy2'],
      dummy3: json['dummy3'],
      dummy4: json['dummy4'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      project:
          json['project'] != null ? Project.fromJson(json['project']) : null,
      comments: json['comments'] != null
          ? List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'system': system ?? '',
      'subsystem': subsystem ?? '',
      'category': category ?? '',
      'description': description,
      'description_original_language': descriptionOriginalLanguage ?? '',
      'reference': reference ?? '',
      'location': location ?? '',
      'recorder': recorder ?? '',
      'recorded': recorded ?? '',
      'responsible_company': responsibleCompany ?? '',
      'responsible_employer': responsibleEmployer ?? '',
      'dead_line': deadLine ?? '',
      'priority': priority ?? '',
      'status': status ?? '',
    };
  }
}

class Project {
  final int? id;
  final int? userId;
  final String? projectName;
  final String? createdAt;
  final String? updatedAt;

  Project({
    this.id,
    this.userId,
    this.projectName,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      userId: json['user_id'],
      projectName: json['project_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'project_name': projectName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Comment {
  final int? id;
  final int? projectIssueId;
  final int? userId;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Comment({
    this.id,
    this.projectIssueId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      projectIssueId: json['project_issue_id'],
      userId: json['user_id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_issue_id': projectIssueId,
      'user_id': userId,
      'comment': comment,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? companyId;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? roleType;
  final String? anonymous;
  final String? status;
  final String? toolUsed;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
    this.roleType,
    this.anonymous,
    this.status,
    this.toolUsed,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      companyId: json['company_id'],
      image: json['image'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      roleType: json['role_type'],
      anonymous: json['anonymous'],
      status: json['status'],
      toolUsed: json['tool_used'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'company_id': companyId,
      'image': image,
      'address': address,
      'phone_number': phoneNumber,
      'role_type': roleType,
      'anonymous': anonymous,
      'status': status,
      'tool_used': toolUsed,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
