class RegResponse {
  RegResponse({
    this.success,
    this.info,
    this.warning,
    this.message,
    this.instruction,
    this.valid,
    this.id,
    this.model,
    this.items,
    this.obj,
    this.error,
  });

  bool? success;
  bool? info;
  bool? warning;
  String? message;
  String? instruction;
  bool? valid;
  dynamic id;
  dynamic model;
  dynamic items;
  Obj? obj;
  String? error;

  factory RegResponse.fromJson(Map<String, dynamic> json) => RegResponse(
        success: json["success"],
        info: json["info"],
        warning: json["warning"],
        message: json["message"] ?? json['error'],
        instruction: json["instruction"],
        valid: json["valid"],
        id: json["id"],
        model: json["model"],
        items: json["items"],
        obj: json["obj"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "info": info,
        "warning": warning,
        "message": message,
        "instruction": instruction,
        "valid": valid,
        "id": id,
        "model": model,
        "items": items,
        "obj": obj,
        "error": error,
      };
}

class Obj {
  dynamic careOfInfo;
  dynamic patientInfo;

  Obj({
    this.careOfInfo,
    this.patientInfo,
  });

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        careOfInfo: json["careOfInfo"],
        patientInfo: json["patientInfo"],
      );

  Map<String, dynamic> toJson() => {
        "careOfInfo": careOfInfo,
        "patientInfo": patientInfo,
      };
}
