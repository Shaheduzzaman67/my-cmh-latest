class AppointmentLookupDetailListResponse {
  AppointmentLookupDetailListResponse({
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
  dynamic message;
  bool? valid;
  dynamic id;
  dynamic model;
  dynamic items;
  Obj? obj;

  factory AppointmentLookupDetailListResponse.fromJson(
          Map<String, dynamic> json) =>
      AppointmentLookupDetailListResponse(
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
  Obj({
    this.serviceCategoryList,
    this.priorityList,
  });

  List<YList>? serviceCategoryList;
  List<YList>? priorityList;

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        serviceCategoryList: List<YList>.from(
            json["serviceCategoryList"].map((x) => YList.fromJson(x))),
        priorityList: List<YList>.from(
            json["priorityList"].map((x) => YList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "serviceCategoryList":
            List<dynamic>.from(serviceCategoryList!.map((x) => x.toJson())),
        "priorityList": List<dynamic>.from(priorityList!.map((x) => x.toJson())),
      };
}

class YList {
  YList({
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

  int? ssCreator;
  String? ssCreatedOn;
  int? ssCreateSession;
  int? ssModifier;
  String? ssModifiedOn;
  int? ssModifiedSession;
  int? companyNo;
  int? id;
  int? lookupdtlNoParent;
  int? lookupNo;
  int? slNo;
  String? dtlName;
  String? dtlDescription;
  int? activeStatus;
  dynamic lookupNoList;
  dynamic lookupdtlNoParentName;
  dynamic lookupDltNoList;

  factory YList.fromJson(Map<String, dynamic> json) => YList(
        ssCreator: json["ssCreator"] == null ? null : json["ssCreator"],
        ssCreatedOn: json["ssCreatedOn"],
        ssCreateSession:
            json["ssCreateSession"] == null ? null : json["ssCreateSession"],
        ssModifier: json["ssModifier"] == null ? null : json["ssModifier"],
        ssModifiedOn:
            json["ssModifiedOn"] == null ? null : json["ssModifiedOn"],
        ssModifiedSession: json["ssModifiedSession"] == null
            ? null
            : json["ssModifiedSession"],
        companyNo: json["companyNo"],
        id: json["id"],
        lookupdtlNoParent: json["lookupdtlNoParent"] == null
            ? null
            : json["lookupdtlNoParent"],
        lookupNo: json["lookupNo"],
        slNo: json["slNo"] == null ? null : json["slNo"],
        dtlName: json["dtlName"],
        dtlDescription:
            json["dtlDescription"] == null ? null : json["dtlDescription"],
        activeStatus: json["activeStatus"],
        lookupNoList: json["lookupNoList"],
        lookupdtlNoParentName: json["lookupdtlNoParentName"],
        lookupDltNoList: json["lookupDltNoList"],
      );

  Map<String, dynamic> toJson() => {
        "ssCreator": ssCreator == null ? null : ssCreator,
        "ssCreatedOn": ssCreatedOn,
        "ssCreateSession": ssCreateSession == null ? null : ssCreateSession,
        "ssModifier": ssModifier == null ? null : ssModifier,
        "ssModifiedOn": ssModifiedOn == null ? null : ssModifiedOn,
        "ssModifiedSession":
            ssModifiedSession == null ? null : ssModifiedSession,
        "companyNo": companyNo,
        "id": id,
        "lookupdtlNoParent":
            lookupdtlNoParent == null ? null : lookupdtlNoParent,
        "lookupNo": lookupNo,
        "slNo": slNo == null ? null : slNo,
        "dtlName": dtlName,
        "dtlDescription": dtlDescription == null ? null : dtlDescription,
        "activeStatus": activeStatus,
        "lookupNoList": lookupNoList,
        "lookupdtlNoParentName": lookupdtlNoParentName,
        "lookupDltNoList": lookupDltNoList,
      };
}
