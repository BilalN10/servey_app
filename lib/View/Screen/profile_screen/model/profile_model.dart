class UserDatum {
  int? id;
  String? name;
  String? email;
  String? companyId;
  String? image;

  dynamic address;
  dynamic phoneNumber;

  UserDatum({
    this.id,
    this.name,
    this.email,
    this.companyId,
    this.image,
    this.address,
    this.phoneNumber,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        companyId: json["company_id"] ?? "",
        image: json["image"] ?? "",
        address: json["address"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "company_id": companyId,
        "image": image,
        "address": address,
        "phone_number": phoneNumber,
      };
}
