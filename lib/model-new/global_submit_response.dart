class GlobalSubmitResponse {
  bool? success;
  String? message;

  GlobalSubmitResponse({
    this.success,
    this.message,
  });

  factory GlobalSubmitResponse.fromJson(Map<String, dynamic> json) => GlobalSubmitResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}