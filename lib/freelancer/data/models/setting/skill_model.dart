class SkillModel {
    int id;
    int userId;
    String skillName;
    String description;

    SkillModel({
        required this.id,
        required this.userId,
        required this.skillName,
        required this.description,
    });

    factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json["id"],
        userId: json["user_id"],
        skillName: json["skill_name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "skill_name": skillName,
        "description": description,
    };
}