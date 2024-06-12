class QualificationModel {
    int? id;
    int userId;
    String title;
    String orgQualification;
    DateTime date;
    String attachment;

    QualificationModel({
      required this.id,
        required this.userId,
        required this.title,
        required this.orgQualification,
        required this.date,
        required this.attachment,
    });

    factory QualificationModel.fromJson(Map<String, dynamic> json) => QualificationModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        orgQualification: json["org_qualification"],
        date: DateTime.parse(json["date"]),
        attachment: json["attachment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "org_qualification": orgQualification,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "attachment": attachment,
    };
}
