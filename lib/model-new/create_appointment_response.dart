class CreateAppointmentResponse {
  CreateAppointmentResponse({
    this.success,
    this.info,
    this.message,
    this.valid,
    this.slotSl,
  });

  bool? success;
  bool? info;
  String? message;
  bool? valid;
  int? slotSl;

  factory CreateAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      CreateAppointmentResponse(
        success: json["success"],
        info: json["info"],
        message: json["message"],
        valid: json["valid"],
        slotSl: json["slotSl"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "info": info,
        "message": message,
        "valid": valid,
        "slotSl": slotSl,
      };
}

