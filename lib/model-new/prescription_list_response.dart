
class PrescriptionListResponse {
  bool? success;
  bool? info;
  bool? warning;
  String? message;
  bool? valid;
  dynamic id;
  dynamic model;
  dynamic items;
  Obj? obj;

  PrescriptionListResponse({
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

  factory PrescriptionListResponse.fromJson(Map<String, dynamic> json) => PrescriptionListResponse(
    success: json["success"],
    info: json["info"],
    warning: json["warning"],
    message: json["message"],
    valid: json["valid"],
    id: json["id"],
    model: json["model"],
    items: json["items"],
    obj: Obj.fromJson(json["obj"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "info": info,
    "warning": warning,
    "message": message,
    "valid": valid,
    "id": id,
    "model": model,
    "items": items,
    "obj": obj!.toJson(),
  };
}

class Obj {
  dynamic draw;
  String? recordsFiltered;
  String? recordsTotal;
  List<PrescriptionData>? data;

  Obj({
    this.draw,
    this.recordsFiltered,
    this.recordsTotal,
    this.data,
  });

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
    draw: json["draw"],
    recordsFiltered: json["recordsFiltered"],
    recordsTotal: json["recordsTotal"],
    data: List<PrescriptionData>.from(json["data"].map((x) => PrescriptionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "draw": draw,
    "recordsFiltered": recordsFiltered,
    "recordsTotal": recordsTotal,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PrescriptionData {
  int? ssCreator;
  String? ssCreatedOn;
  int? ssCreateSession;
  int? ssModifier;
  String? ssModifiedOn;
  int? ssModifiedSession;
  int? companyNo;
  int? id;
  int? registrationNo;
  String? hospitalId;
  String? personalId;
  int? consultationNo;
  String? consultationId;
  int? doctorNo;
  int? appointmentNo;
  int? departmentNo;
  String? departmentName;
  int? roomNo;
  String? roomName;
  String? rank;
  String? unit;
  int? isPatientIn;
  int? isPatientOut;
  dynamic relation;
  int? activeStatus;
  int? ipdFlag;
  dynamic admissionNo;
  dynamic admissionId;
  dynamic wardNo;
  dynamic wardName;
  dynamic bedId;
  dynamic bedName;
  int? continuePresFlag;
  dynamic continuePresNo;
  int? refferedPresFlag;
  dynamic refferedPresNo;
  dynamic doctorInfo;
  dynamic continuePrescriptionList;
  dynamic consultationTypeNo;
  dynamic patientTypeNo;
  dynamic shiftNo;
  dynamic fromDate;
  dynamic toDate;
  dynamic refNo;
  dynamic consulatation;

  PrescriptionData({
    this.ssCreator,
    this.ssCreatedOn,
    this.ssCreateSession,
    this.ssModifier,
    this.ssModifiedOn,
    this.ssModifiedSession,
    this.companyNo,
    this.id,
    this.registrationNo,
    this.hospitalId,
    this.personalId,
    this.consultationNo,
    this.consultationId,
    this.doctorNo,
    this.appointmentNo,
    this.departmentNo,
    this.departmentName,
    this.roomNo,
    this.roomName,
    this.rank,
    this.unit,
    this.isPatientIn,
    this.isPatientOut,
    this.relation,
    this.activeStatus,
    this.ipdFlag,
    this.admissionNo,
    this.admissionId,
    this.wardNo,
    this.wardName,
    this.bedId,
    this.bedName,
    this.continuePresFlag,
    this.continuePresNo,
    this.refferedPresFlag,
    this.refferedPresNo,
    this.doctorInfo,
    this.continuePrescriptionList,
    this.consultationTypeNo,
    this.patientTypeNo,
    this.shiftNo,
    this.fromDate,
    this.toDate,
    this.refNo,
    this.consulatation,
  });

  factory PrescriptionData.fromJson(Map<String, dynamic> json) => PrescriptionData(
    ssCreator: json["ssCreator"],
    ssCreatedOn: json["ssCreatedOn"],
    ssCreateSession: json["ssCreateSession"],
    ssModifier: json["ssModifier"],
    ssModifiedOn: json["ssModifiedOn"],
    ssModifiedSession: json["ssModifiedSession"],
    companyNo: json["companyNo"],
    id: json["id"],
    registrationNo: json["registrationNo"],
    hospitalId: json["hospitalId"],
    personalId: json["personalId"],
    consultationNo: json["consultationNo"],
    consultationId: json["consultationId"],
    doctorNo: json["doctorNo"],
    appointmentNo: json["appointmentNo"],
    departmentNo: json["departmentNo"],
    departmentName: json["departmentName"],
    roomNo: json["roomNo"],
    roomName: json["roomName"],
    rank: json["rank"],
    unit: json["unit"],
    isPatientIn: json["isPatientIn"],
    isPatientOut: json["isPatientOut"],
    relation: json["relation"],
    activeStatus: json["activeStatus"],
    ipdFlag: json["ipdFlag"],
    admissionNo: json["admissionNo"],
    admissionId: json["admissionId"],
    wardNo: json["wardNo"],
    wardName: json["wardName"],
    bedId: json["bedId"],
    bedName: json["bedName"],
    continuePresFlag: json["continuePresFlag"],
    continuePresNo: json["continuePresNo"],
    refferedPresFlag: json["refferedPresFlag"],
    refferedPresNo: json["refferedPresNo"],
    doctorInfo: json["doctorInfo"],
    continuePrescriptionList: json["continuePrescriptionList"],
    consultationTypeNo: json["consultationTypeNo"],
    patientTypeNo: json["patientTypeNo"],
    shiftNo: json["shiftNo"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    refNo: json["refNo"],
    consulatation: json["consulatation"],
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
    "registrationNo": registrationNo,
    "hospitalId": hospitalId,
    "personalId": personalId,
    "consultationNo": consultationNo,
    "consultationId": consultationId,
    "doctorNo": doctorNo,
    "appointmentNo": appointmentNo,
    "departmentNo": departmentNo,
    "departmentName": departmentName,
    "roomNo": roomNo,
    "roomName": roomName,
    "rank": rank,
    "unit": unit,
    "isPatientIn": isPatientIn,
    "isPatientOut": isPatientOut,
    "relation": relation,
    "activeStatus": activeStatus,
    "ipdFlag": ipdFlag,
    "admissionNo": admissionNo,
    "admissionId": admissionId,
    "wardNo": wardNo,
    "wardName": wardName,
    "bedId": bedId,
    "bedName": bedName,
    "continuePresFlag": continuePresFlag,
    "continuePresNo": continuePresNo,
    "refferedPresFlag": refferedPresFlag,
    "refferedPresNo": refferedPresNo,
    "doctorInfo": doctorInfo,
    "continuePrescriptionList": continuePrescriptionList,
    "consultationTypeNo": consultationTypeNo,
    "patientTypeNo": patientTypeNo,
    "shiftNo": shiftNo,
    "fromDate": fromDate,
    "toDate": toDate,
    "refNo": refNo,
    "consulatation": consulatation,
  };
}
