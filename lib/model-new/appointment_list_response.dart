class AppointmentListResponse {
  AppointmentListResponse({
    this.success,
    this.items,
  });

  String? success;
  List<Appointments>? items;

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentListResponse(
        success: json["success"],
        items: json["appointments"] == null
            ? []
            : List<Appointments>.from(
                json["appointments"].map((x) => Appointments.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "appointments": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Appointments {
  Appointments({
    this.ssCreator,
    this.ssCreatedOn,
    this.startTime,
    this.endTime,
    this.ssCreateSession,
    this.ssModifier,
    this.ssModifiedOn,
    this.ssModifiedSession,
    this.id,
    this.slotSl,
    this.timeslotId,
    this.departmentNo,
    this.departmentName,
    this.roomNo,
    this.priorityDesc,
    this.roomDesc,
    this.patientName,
    this.appointmentDate,
    this.appointmentStatus,
    this.personalNumber,
    this.appointmentID,
    this.newStartTime,
    this.newEndTime,
  });

  int? ssCreator;
  String? ssCreatedOn;
  String? startTime;
  String? endTime;
  int? ssCreateSession;
  int? ssModifier;
  int? timeslotId;
  String? ssModifiedOn;
  int? ssModifiedSession;
  int? id;
  int? appointmentID;
  int? departmentNo;
  String? departmentName;
  int? roomNo;
  int? slotSl;
  String? priorityDesc;
  String? roomDesc;
  String? patientName;
  String? appointmentDate;
  String? appointmentStatus;
  String? personalNumber;
  String? newStartTime;
  String? newEndTime;

  factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
        ssCreator: json["ssCreator"],
        ssCreatedOn: json["ssCreatedOn"],
        ssCreateSession: json["ssCreateSession"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        timeslotId: json["timeslotId"],
        ssModifier: json["ssModifier"],
        ssModifiedOn: json["ssModifiedOn"],
        ssModifiedSession: json["ssModifiedSession"],
        id: json["id"],
        slotSl: json["slotSl"],
        departmentNo: json["departmentNo"],
        departmentName: json["departmentName"],
        roomNo: json["roomNo"],
        priorityDesc: json["priorityDesc"],
        roomDesc: json["roomDesc"],
        patientName: json["patientName"],
        appointmentDate: json["appointmentDate"],
        appointmentStatus: json["appointmentStatus"],
        personalNumber: json["personalNumber"],
        appointmentID: json["appointment_id"],
        newStartTime: json["startTime"],
        newEndTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "ssCreator": ssCreator,
        "ssCreatedOn": ssCreatedOn,
        "ssCreateSession": ssCreateSession,
        "start_time": startTime,
        "end_time": endTime,
        "ssModifier": ssModifier,
        "ssModifiedOn": ssModifiedOn,
        "ssModifiedSession": ssModifiedSession,
        "id": id,
        "timeslotId": timeslotId,
        "slotSl": slotSl,
        "departmentNo": departmentNo,
        "departmentName": departmentName,
        "roomNo": roomNo,
        "priorityDesc": priorityDesc,
        "roomDesc": roomDesc,
        "patientName": patientName,
        "appointmentDate": appointmentDate,
        "appointmentStatus": appointmentStatus,
        "personalNumber": personalNumber,
        "appointment_id": appointmentID,
        "startTime": newStartTime,
        "endTime": newEndTime,
      };
}
