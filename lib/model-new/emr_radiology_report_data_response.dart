
class EmrRadiologyReportDataResponse {
  bool? success;
  bool? info;
  bool? warning;
  String? message;
  bool? valid;
  dynamic id;
  dynamic model;
  dynamic items;
  Obj? obj;

  EmrRadiologyReportDataResponse({
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

  factory EmrRadiologyReportDataResponse.fromJson(Map<String, dynamic> json) => EmrRadiologyReportDataResponse(
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
  String? reportText;

  Obj({
    this.reportText,
  });

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
    reportText: json["reportText"],
  );

  Map<String, dynamic> toJson() => {
    "reportText": reportText,
  };
}
