
class EmrInvestigationListResponse {
  bool? success;
  bool? info;
  bool? warning;
  dynamic message;
  bool? valid;
  dynamic id;
  dynamic model;
  List<Item>? items;
  dynamic obj;

  EmrInvestigationListResponse({
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

  factory EmrInvestigationListResponse.fromJson(Map<String, dynamic> json) => EmrInvestigationListResponse(
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
  int? id;
  String? invoiceNo;
  int? regNo;
  String? hospitalNo;
  String? invoiceDateTime;
  int? itemNo;
  String? itemId;
  String? itemName;
  int? buNo;
  String? buName;
  int? totalTest;
  String? testPerform;
  int? stampNo;
  dynamic fromDate;
  dynamic toDate;
  String? status;

  Item({
    this.id,
    this.invoiceNo,
    this.regNo,
    this.hospitalNo,
    this.invoiceDateTime,
    this.itemNo,
    this.itemId,
    this.itemName,
    this.buNo,
    this.buName,
    this.totalTest,
    this.testPerform,
    this.stampNo,
    this.fromDate,
    this.toDate,
    this.status,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    invoiceNo: json["invoiceNo"],
    regNo: json["regNo"],
    hospitalNo: json["hospitalNo"],
    invoiceDateTime: json["invoiceDateTime"],
    itemNo: json["itemNo"],
    itemId: json["itemId"],
    itemName: json["itemName"],
    buNo: json["buNo"],
    buName: json["buName"],
    totalTest: json["totalTest"],
    testPerform: json["testPerform"],
    stampNo: json["stampNo"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoiceNo": invoiceNo,
    "regNo": regNo,
    "hospitalNo": hospitalNo,
    "invoiceDateTime": invoiceDateTime,
    "itemNo": itemNo,
    "itemId": itemId,
    "itemName": itemName,
    "buNo": buNo,
    "buName": buName,
    "totalTest": totalTest,
    "testPerform": testPerform,
    "stampNo": stampNo,
    "fromDate": fromDate,
    "toDate": toDate,
    "status": status,
  };
}
