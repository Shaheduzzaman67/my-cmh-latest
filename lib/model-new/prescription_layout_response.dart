
class PrescriptionLayoutResponse {
  int? ssCreator;
  String? ssCreatedOn;
  int? ssCreateSession;
  int? ssModifier;
  String? ssModifiedOn;
  int? ssModifiedSession;
  int? companyNo;
  int? id;
  dynamic doctorId;
  int? doctorNo;
  dynamic departmentNo;
  dynamic categoryNo;
  bool? isEnable;
  PresEntity? presReportEntity;
  PresEntity? presFormEntity;
  int? activeStatus;

  PrescriptionLayoutResponse({
    this.ssCreator,
    this.ssCreatedOn,
    this.ssCreateSession,
    this.ssModifier,
    this.ssModifiedOn,
    this.ssModifiedSession,
    this.companyNo,
    this.id,
    this.doctorId,
    this.doctorNo,
    this.departmentNo,
    this.categoryNo,
    this.isEnable,
    this.presReportEntity,
    this.presFormEntity,
    this.activeStatus,
  });

  factory PrescriptionLayoutResponse.fromJson(Map<String, dynamic> json) => PrescriptionLayoutResponse(
    ssCreator: json["ssCreator"],
    ssCreatedOn: json["ssCreatedOn"],
    ssCreateSession: json["ssCreateSession"],
    ssModifier: json["ssModifier"],
    ssModifiedOn: json["ssModifiedOn"],
    ssModifiedSession: json["ssModifiedSession"],
    companyNo: json["companyNo"],
    id: json["id"],
    doctorId: json["doctorId"],
    doctorNo: json["doctorNo"],
    departmentNo: json["departmentNo"],
    categoryNo: json["categoryNo"],
    isEnable: json["isEnable"],
    presReportEntity: PresEntity.fromJson(json["presReportEntity"]),
    presFormEntity: PresEntity.fromJson(json["presFormEntity"]),
    activeStatus: json["activeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "ssCreator": ssCreator,
    "ssCreatedOn": ssCreatedOn,
    "ssCreateSession": ssCreateSession,
    "ssModifier": ssModifier,
    "ssModifiedOn": ssModifiedOn,
    "ssModifiedSession": ssModifiedSession,
    "companyNo": companyNo,
    "id": id,
    "doctorId": doctorId,
    "doctorNo": doctorNo,
    "departmentNo": departmentNo,
    "categoryNo": categoryNo,
    "isEnable": isEnable,
    "presReportEntity": presReportEntity!.toJson(),
    "presFormEntity": presFormEntity!.toJson(),
    "activeStatus": activeStatus,
  };
}

class PresEntity {
  int? id;
  String? templateName;
  String? templateLink;
  int? templatedType;
  int? activeStatus;

  PresEntity({
    this.id,
    this.templateName,
    this.templateLink,
    this.templatedType,
    this.activeStatus,
  });

  factory PresEntity.fromJson(Map<String, dynamic> json) => PresEntity(
    id: json["id"],
    templateName: json["templateName"],
    templateLink: json["templateLink"],
    templatedType: json["templatedType"],
    activeStatus: json["activeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "templateName": templateName,
    "templateLink": templateLink,
    "templatedType": templatedType,
    "activeStatus": activeStatus,
  };
}
