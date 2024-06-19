class HistoryProgressModel {
  int? id;
  int? projectAcceptId;
  String? attachment;
  String? title;
  String? description;
  DateTime? senderDate;

  HistoryProgressModel({
    this.id,
    this.projectAcceptId,
    this.attachment,
    this.title,
    this.description,
    this.senderDate,
  });

  factory HistoryProgressModel.fromJson(Map<String, dynamic> json) {
    return HistoryProgressModel(
      id: json['id'],
      projectAcceptId: json['project_accept_id'],
      attachment: json['attachment'],
      title: json['title'],
      description: json['description'],
      senderDate: DateTime.parse(json['sender_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_accept_id': projectAcceptId,
      'attachment': attachment,
      'title': title,
      'description': description,
      'sender_date': senderDate?.toIso8601String(),
    };
  }
}
