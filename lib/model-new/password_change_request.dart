class PasswordChangeRequest {
  String? personalNumber;
  String? otp;
  String? password;

  PasswordChangeRequest({
    this.personalNumber,
    this.otp,
    this.password
  });

  PasswordChangeRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['userName'];
    otp = json['otp'];
    password = json['password'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.personalNumber;
    data['otp'] = this.otp;
    data['password'] = this.password;
    return data;
  }
}
