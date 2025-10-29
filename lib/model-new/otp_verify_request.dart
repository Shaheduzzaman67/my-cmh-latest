class OTPRequest {
  String? personalNumber;
  String? otp;

  OTPRequest({
    this.personalNumber,
    this.otp
  });

  OTPRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['userName'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.personalNumber;
    data['otp'] = this.otp;
    return data;
  }
}
