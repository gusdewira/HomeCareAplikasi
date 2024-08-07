class ProfileEmployerModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? numberPhone;
  String? address;
  String? password;
  String? photoProfile; // Ubah ke String untuk konsistensi
  dynamic summary;
  dynamic earning;
  dynamic portofolioAttachment;
  dynamic profession;
  List<String> role;

  ProfileEmployerModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.numberPhone,
    required this.address,
    required this.password,
    required this.photoProfile,
    this.summary,
    this.earning,
    this.portofolioAttachment,
    this.profession,
    required this.role,
  });

  factory ProfileEmployerModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ProfileEmployerModel(
        id: json["id"] as int?,
        firstName: json["first_name"] as String?,
        lastName: json["last_name"] as String?,
        email: json["email"] as String?,
        numberPhone: json["number_phone"] as String?,
        address: json["address"] as String?,
        password: json["password"] as String?,
        photoProfile: json["profile_photo"] as String?,
        summary: json["summary"],
        earning: json["earning"],
        portofolioAttachment: json["portofolio_attachment"],
        profession: json["profession"],
        role: List<String>.from(json["role"] as List<dynamic>? ?? []),
      );
    } else if (json is List<dynamic> && json.isNotEmpty) {
      return ProfileEmployerModel.fromJson(json.first);
    } else {
      throw const FormatException("Invalid format for ProfileEmployerModel");
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
    "profile_photo": photoProfile,
    "summary": summary,
    "earning": earning,
    "portofolio_attachment": portofolioAttachment,
    "profession": profession,
    "role": List<dynamic>.from(role.map((x) => x)),
  };
}


class ProfileEmployerModel1 {
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

  ProfileEmployerModel1({
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

  factory ProfileEmployerModel1.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Invalid format for ProfileEmployerModel");
    }
    return ProfileEmployerModel1(
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
      portofolioAttachment: json["portofolio_attachment"],
      profession: json["profession"],
      role: List<String>.from(json["role"] as List<dynamic>? ?? []),
    );
  }

  factory ProfileEmployerModel1.fromListJson(List<dynamic>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) {
      throw const FormatException("Invalid format for ProfileEmployerModel");
    }
    return ProfileEmployerModel1.fromJson(jsonList.first as Map<String, dynamic>);
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
      "portofolio_attachment": portofolioAttachment,
      "profession": profession,
      "role": role,
    };
  }
}
