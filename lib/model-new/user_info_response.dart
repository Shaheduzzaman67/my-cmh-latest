class UserInfoResponse {
  UserInfoResponse({
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

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        success: json["success"],
        info: json["info"],
        warning: json["warning"],
        message: json["message"],
        valid: json["valid"],
        id: json["id"],
        model: json["model"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "obj": obj,
      };
}

class Item {
  Item(
      {this.patientName,
      this.unitNo,
      this.relationshipSerialNo,
      this.personalNumber,
      this.regType,
      this.photo});

  String? patientName;
  UnitNo? unitNo;
  int? relationshipSerialNo;
  String? personalNumber;
  int? regType;
  String? photo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          personalNumber == other.personalNumber;

  @override
  int get hashCode => personalNumber.hashCode;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        patientName: json["patientName"],
        unitNo: UnitNo.fromJson(json["unitNo"]),
        relationshipSerialNo: json["relationshipSerialNo"],
        personalNumber: json["personalNumber"],
        regType: json["regType"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "patientName": patientName,
        "unitNo": unitNo!.toJson(),
        "relationshipSerialNo": relationshipSerialNo,
        "personalNumber": personalNumber,
        "regType": regType,
        "photo": photo,
      };
}

class UnitNo {
  UnitNo({
    this.ssCreator,
    this.ssCreatedOn,
    this.ssCreateSession,
    this.ssModifier,
    this.ssModifiedOn,
    this.ssModifiedSession,
    this.companyNo,
    this.id,
    this.lookupdtlNoParent,
    this.lookupNo,
    this.slNo,
    this.dtlName,
    this.dtlDescription,
    this.activeStatus,
    this.lookupNoList,
    this.lookupdtlNoParentName,
    this.lookupDltNoList,
  });

  dynamic ssCreator;
  String? ssCreatedOn;
  dynamic ssCreateSession;
  dynamic ssModifier;
  dynamic ssModifiedOn;
  dynamic ssModifiedSession;
  int? companyNo;
  int? id;
  int? lookupdtlNoParent;
  int? lookupNo;
  dynamic slNo;
  String? dtlName;
  String? dtlDescription;
  int? activeStatus;
  dynamic lookupNoList;
  dynamic lookupdtlNoParentName;
  dynamic lookupDltNoList;

  factory UnitNo.fromJson(Map<String, dynamic> json) => UnitNo(
        ssCreator: json["ssCreator"],
        ssCreatedOn: json["ssCreatedOn"],
        ssCreateSession: json["ssCreateSession"],
        ssModifier: json["ssModifier"],
        ssModifiedOn: json["ssModifiedOn"],
        ssModifiedSession: json["ssModifiedSession"],
        companyNo: json["companyNo"],
        id: json["id"],
        lookupdtlNoParent: json["lookupdtlNoParent"],
        lookupNo: json["lookupNo"],
        slNo: json["slNo"],
        dtlName: json["dtlName"],
        dtlDescription: json["dtlDescription"],
        activeStatus: json["activeStatus"],
        lookupNoList: json["lookupNoList"],
        lookupdtlNoParentName: json["lookupdtlNoParentName"],
        lookupDltNoList: json["lookupDltNoList"],
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
        "lookupdtlNoParent": lookupdtlNoParent,
        "lookupNo": lookupNo,
        "slNo": slNo,
        "dtlName": dtlName,
        "dtlDescription": dtlDescription,
        "activeStatus": activeStatus,
        "lookupNoList": lookupNoList,
        "lookupdtlNoParentName": lookupdtlNoParentName,
        "lookupDltNoList": lookupDltNoList,
      };
}
