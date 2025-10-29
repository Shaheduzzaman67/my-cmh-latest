class DepartmentListResponseModel {
  bool? success;
  String? message;
  List<DepartmentItem>? items;

  DepartmentListResponseModel({
    this.success,
    this.message,
    this.items,
  });

  factory DepartmentListResponseModel.fromJson(Map<String, dynamic> json) =>
      DepartmentListResponseModel(
        success: json["success"],
        message: json["message"],
        items: json["items"] == null
            ? []
            : List<DepartmentItem>.from(
                json["items"]!.map((x) => DepartmentItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class DepartmentItem {
  int? id;
  String? buName;
  String? buParentNm;
  String? buId;
  int? activeStatus;
  String? description;
  int? buTypeNo;
  String? buNameTree;
  String? buNameLevel;
  int? ipdDepartment;
  int? deptBIllActivationFlag;
  String? businessSchedule;
  int? onlineFlag;

  DepartmentItem({
    this.id,
    this.buName,
    this.buParentNm,
    this.buId,
    this.activeStatus,
    this.description,
    this.buTypeNo,
    this.buNameTree,
    this.buNameLevel,
    this.ipdDepartment,
    this.deptBIllActivationFlag,
    this.businessSchedule,
    this.onlineFlag,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory DepartmentItem.fromJson(Map<String, dynamic> json) => DepartmentItem(
        id: json["id"],
        buName: json["buName"],
        buParentNm: json["buParentNm"],
        buId: json["buId"],
        activeStatus: json["activeStatus"],
        description: json["description"],
        buTypeNo: json["buTypeNo"],
        buNameTree: json["buNameTree"],
        buNameLevel: json["buNameLevel"],
        ipdDepartment: json["ipdDepartment"],
        deptBIllActivationFlag: json["deptBIllActivationFlag"],
        businessSchedule: json["businessSchedule"],
        onlineFlag: json["onlineFlag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "buName": buName,
        "buParentNm": buParentNm,
        "buId": buId,
        "activeStatus": activeStatus,
        "description": description,
        "buTypeNo": buTypeNo,
        "buNameTree": buNameTree,
        "buNameLevel": buNameLevel,
        "ipdDepartment": ipdDepartment,
        "deptBIllActivationFlag": deptBIllActivationFlag,
        "businessSchedule": businessSchedule,
        "onlineFlag": onlineFlag,
      };
}
