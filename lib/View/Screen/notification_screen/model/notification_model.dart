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
