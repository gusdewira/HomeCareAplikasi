class ProjectBidModel {
    int id;
    int projectOfferId;
    DateTime startProject;
    DateTime endProject;
    DateTime acceptDate;
    String status;

    ProjectBidModel({
        required this.id,
        required this.projectOfferId,
        required this.startProject,
        required this.endProject,
        required this.acceptDate,
        required this.status,
    });

    factory ProjectBidModel.fromJson(Map<String, dynamic> json) => ProjectBidModel(
        id: json["id"],
        projectOfferId: json["project_offer_id"],
        startProject: DateTime.parse(json["start_project"]),
        endProject: DateTime.parse(json["end_project"]),
        acceptDate: DateTime.parse(json["accept_date"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_offer_id": projectOfferId,
        "start_project": "${startProject.year.toString().padLeft(4, '0')}-${startProject.month.toString().padLeft(2, '0')}-${startProject.day.toString().padLeft(2, '0')}",
        "end_project": "${endProject.year.toString().padLeft(4, '0')}-${endProject.month.toString().padLeft(2, '0')}-${endProject.day.toString().padLeft(2, '0')}",
        "accept_date": acceptDate.toIso8601String(),
        "status": status,
    };
}
