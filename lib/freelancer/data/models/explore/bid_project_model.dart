class BidProjectModel {
    int id;
    String projectId;
    int offerBy;
    DateTime offerDate;
    String offerAmount;
    String offerReason;
    String status;
    String estimatedDuration;

    BidProjectModel({
        required this.id,
        required this.projectId,
        required this.offerBy,
        required this.offerDate,
        required this.offerAmount,
        required this.offerReason,
        required this.status,
        required this.estimatedDuration,
    });

    factory BidProjectModel.fromJson(Map<String, dynamic> json) => BidProjectModel(
        id: json["id"],
        projectId: json["project_id"],
        offerBy: json["offer_by"],
        offerDate: DateTime.parse(json["offer_date"]),
        offerAmount: json["offer_amount"],
        offerReason: json["offer_reason"],
        status: json["status"],
        estimatedDuration: json["estimated_duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "offer_by": offerBy,
        "offer_date": offerDate.toIso8601String(),
        "offer_amount": offerAmount,
        "offer_reason": offerReason,
        "status": status,
        "estimated_duration": estimatedDuration,
    };
}
