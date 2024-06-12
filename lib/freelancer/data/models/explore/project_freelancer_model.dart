class ProjectFreelancerModel {
  int id;
  String title;
  String description;
  String attachment;
  double longitude;
  double latitude;
  DateTime startDate;
  dynamic penawaran;
  DateTime endDate;
  String startSalary;
  String endSalary;
  List<NameCategory> nameCategorys;

  ProjectFreelancerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.attachment,
    required this.longitude,
    required this.latitude,
    required this.startDate,
    required this.penawaran,
    required this.endDate,
    required this.startSalary,
    required this.endSalary,
    required this.nameCategorys,
  });

  String getDayMonthString(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}';
  }

  factory ProjectFreelancerModel.fromJson(Map<String, dynamic> json) =>
      ProjectFreelancerModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        attachment: json["attachment"],
        longitude: json["longitude"]?.toDouble() ?? 0.0, 
        latitude: json["latitude"]?.toDouble() ?? 0.0, 
        startDate: DateTime.parse(json["start_date"]),
        penawaran: json["penawaran"],
        endDate: DateTime.parse(json["end_date"]),
        startSalary: json["start_salary"],
        endSalary: json["end_salary"],
        nameCategorys: List<NameCategory>.from(json["name_categorys"].map((x) => NameCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "attachment": attachment,
        "longitude": longitude,
        "latitude": latitude,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "penawaran": penawaran,
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_salary": startSalary,
        "end_salary": endSalary,
        "name_categorys": List<dynamic>.from(nameCategorys.map((x) => x.toJson())),
      };
}

   class NameCategory {
    int id;
    String name;
    dynamic createdAt;
    dynamic updatedAt;
    Pivot pivot;

    NameCategory({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.pivot,
    });

    factory NameCategory.fromJson(Map<String, dynamic> json) => NameCategory(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot.toJson(),
    };
}

class Pivot {
    int projectId;
    int skillCategoryId;

    Pivot({
        required this.projectId,
        required this.skillCategoryId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        projectId: json["project_id"],
        skillCategoryId: json["skill_category_id"],
    );

    Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "skill_category_id": skillCategoryId,
    };
}
