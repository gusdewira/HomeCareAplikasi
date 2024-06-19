class ProjectFreelancerModel {
  int? id;
  String? title;
  String? description;
  String? attachment;
  double? longitude;
  double? latitude;
  DateTime? startDate;
  DateTime? endDate;
  List<String>? nameCategories;
  double? startSalary;
  double? endSalary;
  DateTime? createdAt;
  Map<String, dynamic>? user;

  ProjectFreelancerModel({
    this.id,
    this.title,
    this.description,
    this.attachment,
    this.longitude,
    this.latitude,
    this.startDate,
    this.endDate,
    this.nameCategories,
    this.startSalary,
    this.endSalary,
    this.createdAt,
    this.user
  });

  factory ProjectFreelancerModel.fromJson(Map<String, dynamic> json) =>
      ProjectFreelancerModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        attachment: json['attachment'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        nameCategories: (json['name_categorys'] as List<dynamic>)
            .map((category) => category['name'] as String)
            .toList(),
        startSalary: double.parse(json['start_salary']),
        endSalary: double.parse(json['end_salary']),
        createdAt: DateTime.parse(json['created_at']['raw']),
        user: json['user']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "attachment": attachment,
        "longitude": longitude,
        "latitude": latitude,
        "start_date": startDate,
        "end_date": endDate,
        "name_categorys": nameCategories,
        "start_salary": startSalary,
        "end_salary": endSalary,
        "created_at": createdAt,
        "user": user
      };
}
