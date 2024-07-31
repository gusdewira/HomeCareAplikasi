class NotificationModel {
  int? id;
  UserModel? sentTo;
  UserModel? sender;
  String? title;
  String? notifText;
  DateTime? sentAt;
  String? isRead;

  NotificationModel({
    this.id,
    this.sentTo,
    this.sender,
    this.title,
    this.notifText,
    this.sentAt,
    this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      sentTo: json['sent_to'] != null ? UserModel.fromJson(json['sent_to']) : null,
      sender: json['sender'] != null ? UserModel.fromJson(json['sender']) : null,
      title: json['title'],
      notifText: json['notif_text'],
      sentAt: DateTime.parse(json['sent_at']),
      isRead: json['is_read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sent_to': sentTo?.toJson(),
      'sender': sender?.toJson(),
      'title': title,
      'notif_text': notifText,
      'sent_at': sentAt?.toIso8601String(),
      'is_read': isRead,
    };
  }
}

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? numberPhone;
  String? address;
  String? profilePhoto;
  String? profession;
  String? summary;
  String? earning;
  String? portofolioAttachment;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.numberPhone,
    this.address,
    this.profilePhoto,
    this.profession,
    this.summary,
    this.earning,
    this.portofolioAttachment,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      numberPhone: json['number_phone'],
      address: json['address'],
      profilePhoto: json['profile_photo'],
      profession: json['profession'],
      summary: json['summary'],
      earning: json['earning'],
      portofolioAttachment: json['portofolio_attachment'],
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'number_phone': numberPhone,
      'address': address,
      'profile_photo': profilePhoto,
      'profession': profession,
      'summary': summary,
      'earning': earning,
      'portofolio_attachment': portofolioAttachment,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}