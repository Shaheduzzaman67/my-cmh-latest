class PasswordChangeResponse {
  String? userName;
  int? otpStatus;
  String? otpMessage;

  PasswordChangeResponse({
    this.userName,
    this.otpStatus,
    this.otpMessage,
  });

  factory PasswordChangeResponse.fromJson(Map<String, dynamic> json) => PasswordChangeResponse(
    userName: json["userName"],
    otpStatus: json["otpStatus"],
    otpMessage: json["otpMessage"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "otpStatus": otpStatus,
    "otpMessage": otpMessage,
  };
}