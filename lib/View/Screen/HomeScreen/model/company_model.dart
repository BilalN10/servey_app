class AllCompanyModel {
  final int id;
  final String name;
  final String email;
  final String? companyId;
  final String? image;
  final String address;
  final String phoneNumber;
  final String? toolUsed;
  final String createdAt;

  AllCompanyModel({
    required this.id,
    required this.name,
    required this.email,
    this.companyId,
    this.image,
    required this.address,
    required this.phoneNumber,
    this.toolUsed,
    required this.createdAt,
  });

  factory AllCompanyModel.fromJson(Map<String, dynamic> json) {
    return AllCompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      companyId: json['company_id'],
      image: json['image'],
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      toolUsed: json['tool_used'],
      createdAt: json['created_at'] ?? '',
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
      'tool_used': toolUsed,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return 'AllCompanyModel(id: $id, name: $name, email: $email, address: $address, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AllCompanyModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class CompanyData {
  final int currentPage;
  final List<AllCompanyModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  CompanyData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => AllCompanyModel.fromJson(item))
              .toList() ??
          [],
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? 0,
      lastPage: json['last_page'] ?? 1,
      lastPageUrl: json['last_page_url'] ?? '',
      links: (json['links'] as List<dynamic>?)
              ?.map((item) => Link.fromJson(item))
              .toList() ??
          [],
      nextPageUrl: json['next_page_url'],
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 10,
      prevPageUrl: json['prev_page_url'],
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((item) => item.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links.map((item) => item.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class CompanyResponse {
  final bool status;
  final String message;
  final int code;
  final CompanyData data;

  CompanyResponse({
    required this.status,
    required this.message,
    required this.code,
    required this.data,
  });

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
      data: CompanyData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'code': code,
      'data': data.toJson(),
    };
  }

  @override
  String toString() {
    return 'CompanyResponse(status: $status, message: $message, code: $code, data: $data)';
  }
}
