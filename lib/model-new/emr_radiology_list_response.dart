// To parse this JSON data, do
//
//     final emrRadiologyReportListResponse = emrRadiologyReportListResponseFromJson(jsonString);


class EmrRadiologyReportListResponse {
  bool? success;
  bool? info;
  bool? warning;
  String? message;
  bool? valid;
  dynamic id;
  dynamic model;
  List<RadiologyReportItem>? items;
  dynamic obj;

  EmrRadiologyReportListResponse({
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

  factory EmrRadiologyReportListResponse.fromJson(Map<String, dynamic> json) => EmrRadiologyReportListResponse(
    success: json["success"],
    info: json["info"],
    warning: json["warning"],
    message: json["message"],
    valid: json["valid"],
    id: json["id"],
    model: json["model"],
    items: List<RadiologyReportItem>.from(json["items"].map((x) => RadiologyReportItem.fromJson(x))),
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

class RadiologyReportItem {
  dynamic billInvoiceNo;
  int? regNo;
  int? invoiceNo;
  int? itemNo;
  String? itemId;
  String? itemName;
  int? buNo;
  String? buName;
  int? totalTest;
  dynamic billInvoiceDateStr;
  dynamic billInvoiceDate;
  int? billSetFlag;
  String? accessionId;
  String? finalizeDate;
  String? draftDate;
  int? finalizeFlag;
  int? draftedFlag;
  String? imgCaptureDate;
  dynamic verifyDate;
  int? reviewedFlag;

  RadiologyReportItem({
    this.billInvoiceNo,
    this.regNo,
    this.invoiceNo,
    this.itemNo,
    this.itemId,
    this.itemName,
    this.buNo,
    this.buName,
    this.totalTest,
    this.billInvoiceDateStr,
    this.billInvoiceDate,
    this.billSetFlag,
    this.accessionId,
    this.finalizeDate,
    this.draftDate,
    this.finalizeFlag,
    this.draftedFlag,
    this.imgCaptureDate,
    this.verifyDate,
    this.reviewedFlag,
  });

  factory RadiologyReportItem.fromJson(Map<String, dynamic> json) => RadiologyReportItem(
    billInvoiceNo: json["billInvoiceNo"],
    regNo: json["regNo"],
    invoiceNo: json["invoiceNo"],
    itemNo: json["itemNo"],
    itemId: json["itemId"],
    itemName: json["itemName"],
    buNo: json["buNo"],
    buName: json["buName"],
    totalTest: json["totalTest"],
    billInvoiceDateStr: json["billInvoiceDateStr"],
    billInvoiceDate: json["billInvoiceDate"],
    billSetFlag: json["billSetFlag"],
    accessionId: json["accessionId"],
    finalizeDate: json["finalizeDate"],
    draftDate: json["draftDate"],
    finalizeFlag: json["finalizeFlag"],
    draftedFlag: json["draftedFlag"],
    imgCaptureDate: json["imgCaptureDate"],
    verifyDate: json["verifyDate"],
    reviewedFlag: json["reviewedFlag"],
  );

  Map<String, dynamic> toJson() => {
    "billInvoiceNo": billInvoiceNo,
    "regNo": regNo,
    "invoiceNo": invoiceNo,
    "itemNo": itemNo,
    "itemId": itemId,
    "itemName": itemName,
    "buNo": buNo,
    "buName": buName,
    "totalTest": totalTest,
    "billInvoiceDateStr": billInvoiceDateStr,
    "billInvoiceDate": billInvoiceDate,
    "billSetFlag": billSetFlag,
    "accessionId": accessionId,
    "finalizeDate": finalizeDate,
    "draftDate": draftDate,
    "finalizeFlag": finalizeFlag,
    "draftedFlag": draftedFlag,
    "imgCaptureDate": imgCaptureDate,
    "verifyDate": verifyDate,
    "reviewedFlag": reviewedFlag,
  };
}
