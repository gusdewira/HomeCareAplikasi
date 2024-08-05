class ProfileFreelancerModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? numberPhone;
  String? address;
  String? password;
  String? photoProfile;
  String? summary;
  String? earning;
  List<PortofolioAttachment>? portofolioAttachments;
  String? profession;
  List<String>? role;
  List? reviews;

  ProfileFreelancerModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.numberPhone,
    this.address,
    this.password,
    this.photoProfile,
    this.summary,
    this.earning,
    this.portofolioAttachments,
    this.profession,
    this.role,
    this.reviews,
  });

  factory ProfileFreelancerModel.fromJson(Map<String, dynamic> json) {
    return ProfileFreelancerModel(
      id: json["id"] as int?,
      firstName: json["first_name"] as String?,
      lastName: json["last_name"] as String?,
      email: json["email"] as String?,
      numberPhone: json["number_phone"] as String?,
      address: json["address"] as String?,
      password: json["password"] as String?,
      photoProfile: json["profile_photo"] as String?,
      summary: json["summary"] as String?,
      earning: json["earning"] as String?,
      portofolioAttachments: (json["portofolio_attachments"] as List<dynamic>?)
          ?.map((item) =>
              PortofolioAttachment.fromJson(item as Map<String, dynamic>))
          .toList(),
      profession: json["profession"] as String?,
      role: (json["role"] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
          reviews: (json["reviews"] as List<dynamic>?)?.toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "number_phone": numberPhone,
        "address": address,
        "password": password,
        "profile_photo": photoProfile,
        "summary": summary,
        "earning": earning,
        "portofolio_attachments": portofolioAttachments
            ?.map((e) => e.toJson())
            .toList(),
        "profession": profession,
        "role": role,
        "reviews": reviews,
      };
}

class PortofolioAttachment {
  final int id;
  final String path;

  PortofolioAttachment({
    required this.id,
    required this.path,
  });

  factory PortofolioAttachment.fromJson(Map<String, dynamic> json) {
    return PortofolioAttachment(
      id: json['id'] as int,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'path': path,
      };
}

class ProfileFreelancerModel1 {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? numberPhone;
  String? address;
  String? password;
  dynamic photoProfile;
  dynamic summary;
  dynamic earning;
  dynamic portofolioAttachment;
  dynamic profession;
  List<String>? role;

  ProfileFreelancerModel1({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.numberPhone,
    this.address,
    this.password,
    this.photoProfile,
    this.summary,
    this.earning,
    this.portofolioAttachment,
    this.profession,
    this.role,
  });

  factory ProfileFreelancerModel1.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Invalid format for ProfileFreelancerModel");
    }
    return ProfileFreelancerModel1(
      id: json["id"] as int?,
      firstName: json["first_name"] as String?,
      lastName: json["last_name"] as String?,
      email: json["email"] as String?,
      numberPhone: json["number_phone"] as String?,
      address: json["address"] as String?,
      password: json["password"] as String?,
      photoProfile: json["profile_photo"],
      summary: json["summary"],
      earning: json["earning"],
      portofolioAttachment:
          json["portofolio_attachments"] as List<dynamic>? ?? [],
      profession: json["profession"],
      role: List<String>.from(json["role"] as List<dynamic>? ?? []),
    );
  }

  factory ProfileFreelancerModel1.fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) {
      throw const FormatException("Invalid format for ProfileFreelancerModel");
    }
    return ProfileFreelancerModel1.fromJson(
        jsonList.first as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "number_phone": numberPhone,
      "address": address,
      "password": password,
      "profile_photo": photoProfile,
      "summary": summary,
      "earning": earning,
      "portofolio_attachments": portofolioAttachment,
      "profession": profession,
      "role": role,
    };
  }
}
