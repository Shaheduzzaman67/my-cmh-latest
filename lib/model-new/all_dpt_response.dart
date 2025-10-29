class AllDptResponse {
  AllDptResponse({
    this.success,
    this.info,
    this.warning,
    this.message,
    this.valid,
    this.id,
    this.model,
    this.items,
    this.obj,
  });

  bool? success;
  bool? info;
  bool? warning;
  String? message;
  bool? valid;
  dynamic id;
  dynamic model;
  List<Item>? items;
  dynamic obj;

  factory AllDptResponse.fromJson(Map<String, dynamic> json) => AllDptResponse(
        success: json["success"],
        info: json["info"],
        warning: json["warning"],
        message: json["message"],
        valid: json["valid"],
        id: json["id"],
        model: json["model"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        obj: json["obj"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "info": info,
        "warning": warning,
        "message": message,
        "valid": valid,
        "id": id,
        "model": model,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "obj": obj,
      };
}

class Item {
  Item({
    this.id,
    this.departmentNo,
    this.departmentName,
    this.appointmentDate,
    this.appointmentPatientPerRoom,
    this.seenPatientPerRoom,
    this.appointmentPatientPerDept,
    this.totalRoomPerDepartment,
    this.roomName,
    this.roomName2,
    this.roomNo,
    this.companyNo,
    this.departmentNoList,
    this.tagRoomNo,
  });

  int? id;
  int? departmentNo;
  String? departmentName;
  AppointmentDate? appointmentDate;
  int? appointmentPatientPerRoom;
  int? seenPatientPerRoom;
  int? appointmentPatientPerDept;
  int? totalRoomPerDepartment;
  String? roomName;
  String? roomName2;
  int? roomNo;
  int? companyNo;
  dynamic departmentNoList;
  String? tagRoomNo;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        departmentNo: json["departmentNo"],
        departmentName: json["departmentName"],
        appointmentDate: appointmentDateValues.map[json["appointmentDate"]],
        appointmentPatientPerRoom: json["appointmentPatientPerRoom"],
        seenPatientPerRoom: json["seenPatientPerRoom"],
        appointmentPatientPerDept: json["appointmentPatientPerDept"],
        totalRoomPerDepartment: json["totalRoomPerDepartment"],
        roomName: json["roomName"],
        roomName2: json["roomName2"],
        roomNo: json["roomNo"],
        companyNo: json["companyNo"],
        departmentNoList: json["departmentNoList"],
        tagRoomNo: json["tagRoomNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departmentNo": departmentNo,
        "departmentName": departmentName,
        "appointmentDate": appointmentDateValues.reverse[appointmentDate],
        "appointmentPatientPerRoom": appointmentPatientPerRoom,
        "seenPatientPerRoom": seenPatientPerRoom,
        "appointmentPatientPerDept": appointmentPatientPerDept,
        "totalRoomPerDepartment": totalRoomPerDepartment,
        "roomName": roomName,
        "roomName2": roomName2,
        "roomNo": roomNo,
        "companyNo": companyNo,
        "departmentNoList": departmentNoList,
        "tagRoomNo": tagRoomNo,
      };
}

enum AppointmentDate { THE_20230108_T18_00000000000 }

final appointmentDateValues = EnumValues({
  "2023-01-08T18:00:00.000+0000": AppointmentDate.THE_20230108_T18_00000000000
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
