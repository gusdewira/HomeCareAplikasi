class ProfileFreelancerModel {
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
  List<String> role;

  ProfileFreelancerModel({
    this.id,
    required this.firstName, 
    required this.lastName, 
    required this.email, 
    required this.numberPhone, 
    required this.address, 
    required this.password,
    this.photoProfile,
    this.summary,
    this.earning,
    this.portofolioAttachment,
    this.profession,
    required this.role,
  });

  factory ProfileFreelancerModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ProfileFreelancerModel(
        id: json["id"] as int?,
        firstName: json["first_name"] as String?,
        lastName: json["last_name"] as String?,
        email: json["email"] as String?,
        numberPhone: json["number_phone"] as String?,
        address: json["address"] as String?,
        password: json["password"] as String?,
        photoProfile: json["photo_profile"],
        summary: json["summary"],
        earning: json["earning"],
        portofolioAttachment: json["portofolio_attachment"],
        profession: json["profession"],
        role: List<String>.from(json["role"] as List<dynamic>? ?? []),
      );
    } else if (json is List<dynamic> && json.isNotEmpty) {
      return ProfileFreelancerModel.fromJson(json.first);
    } else {
      throw const FormatException("Invalid format for ProfileFreelancerModel");
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "number_phone": numberPhone,
        "address": address,
        "password": password,
        "photo_profile": photoProfile,
        "summary": summary,
        "earning": earning,
        "portofolio_attachment": portofolioAttachment,
        "profession": profession,
        "role": List<dynamic>.from(role.map((x) => x)),
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
      photoProfile: json["photo_profile"],
      summary: json["summary"],
      earning: json["earning"],
      portofolioAttachment: json["portofolio_attachment"],
      profession: json["profession"],
      role: List<String>.from(json["role"] as List<dynamic>? ?? []),
    );
  }

  factory ProfileFreelancerModel1.fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) {
      throw const FormatException("Invalid format for ProfileFreelancerModel");
    }
    return ProfileFreelancerModel1.fromJson(jsonList.first as Map<String, dynamic>);
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
      "photo_profile": photoProfile,
      "summary": summary,
      "earning": earning,
      "portofolio_attachment": portofolioAttachment,
      "profession": profession,
      "role": role,
    };
  }
}
