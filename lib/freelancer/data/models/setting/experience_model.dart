class ExperienceModel {
  int? id;
  int? userId;
  String? title;
  String? company;
  String? description;
  DateTime? startDate;
  DateTime? endDate;

  ExperienceModel({
    this.id,
    this.userId,
    this.title,
    this.company,
    this.description,
    this.startDate,
    this.endDate,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      ExperienceModel(
        id: json['id'],
        userId: json["user_id"],
        title: json["title"],
        company: json["company"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "company": company,
        "description": description,
        "start_date": startDate != null
            ? "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}"
            : null,
        "end_date": endDate != null
            ? "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}"
            : null,
      };
}
