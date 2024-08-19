// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  String? message;
  List<NotificationDatum>? notifications;
  int? unreadCount;

  NotificationModel({
    this.message,
    this.notifications,
    this.unreadCount,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        message: json["message"],
        notifications: json["notifications"] == null
            ? []
            : List<NotificationDatum>.from(json["notifications"]!
                .map((x) => NotificationDatum.fromJson(x))),
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "unread_count": unreadCount,
      };
}

class NotificationDatum {
  NotificationData? data;
  String? readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationDatum({
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
        readAt: json["read_at"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "read_at": readAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class NotificationData {
  String? image;
  String? name;
  String? message;
  String? time;

  bool? isGlobal;

  NotificationData({
    this.image,
    this.name,
    this.message,
    this.time,
    this.isGlobal,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        image: json["image"],
        name: json["name"],
        message: json["message"],
        time: json["time"],
        isGlobal: json["isGlobal"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "message": message,
        "time": time,
        "isGlobal": isGlobal,
      };
}
