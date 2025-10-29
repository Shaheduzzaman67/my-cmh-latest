

class TimeSlotModelResponse {
  String? success;
  List<Timeslot>? timeslots;

  TimeSlotModelResponse({
    this.success,
    this.timeslots,
  });

  factory TimeSlotModelResponse.fromJson(Map<String, dynamic> json) => TimeSlotModelResponse(
    success: json["success"],
    timeslots: List<Timeslot>.from(json["timeslots"].map((x) => Timeslot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "timeslots": List<dynamic>.from(timeslots!.map((x) => x.toJson())),
  };
}

class Timeslot {
  int? id;
  int? status;
  String? category;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  dynamic updatedAt;

  Timeslot({
    this.id,
    this.status,
    this.category,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
    id: json["id"],
    status: json["status"],
    category: json["category"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "category": category,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
  };
}
