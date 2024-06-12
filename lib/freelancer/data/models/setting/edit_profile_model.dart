class EditProfileModel {
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
  dynamic profession;
  List<String> role;

  EditProfileModel({
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
    this.profession,
    required this.role,
  });
factory EditProfileModel.fromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return EditProfileModel(
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
      profession: json["profession"],
      role: List<String>.from(json["role"] as List<dynamic>? ?? []), // Handle null or empty list
    );
  } else if (json is List<dynamic> && json.isNotEmpty) {
    return EditProfileModel.fromJson(json.first);
  } else {
    throw const FormatException("Invalid format for EditProfileModel");
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
        "profession": profession,
        "role": List<dynamic>.from(role.map((x) => x)),
      };
}
