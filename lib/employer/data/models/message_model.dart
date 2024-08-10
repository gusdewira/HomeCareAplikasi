class User {
  final int id;
  final String? username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String numberPhone;
  final String address;
  final String? profilePhoto;
  final String? summary;
  final String? earning;
  final String? portofolioAttachment;
  final String? profession;

  User({
    required this.id,
    this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.numberPhone,
    required this.address,
    this.profilePhoto,
    this.summary,
    this.earning,
    this.portofolioAttachment,
    this.profession,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      numberPhone: json['number_phone'],
      address: json['address'],
      profilePhoto: json['profile_photo'],
      summary: json['summary'],
      earning: json['earning'],
      portofolioAttachment: json['portofolio_attachment'],
      profession: json['profession'],
    );
  }
}

class Conversation {
  final int id;
  final User user1;
  final User user2;

  Conversation({
    required this.id,
    required this.user1,
    required this.user2,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      user1: User.fromJson(json['user1']),
      user2: User.fromJson(json['user2']),
    );
  }
}

class MessageModel {
  final int? id;
  final int senderId;
  final Conversation conversation;
  final String messageText;
  final String? attachments;
  final String? readBy;

  MessageModel({
    this.id,
    required this.senderId,
    required this.conversation,
    required this.messageText,
    this.attachments,
    this.readBy,
  });

  MessageModel copyWith({
    int? id,
    int? senderId,
    String? messageText,
    Conversation? conversation,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      messageText: messageText ?? this.messageText,
      conversation: conversation ?? this.conversation,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['sender_id'],
      conversation: Conversation.fromJson(json['conversation']),
      messageText: json['message_text'],
      attachments: json['attachments'],
      readBy: json['read_by'],
    );
  }
}
