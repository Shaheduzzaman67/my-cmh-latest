class ForgotPassReq {
  String? personalId;
  String? dob;
  String? mobile;

  ForgotPassReq({
    this.personalId,
  });

  ForgotPassReq.fromJson(Map<String, dynamic> json) {
    personalId = json['userName'];
    dob = json['dob'];
    mobile = json['phoneMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.personalId;
    data['dob'] = this.dob;
    data['phoneMobile'] = this.mobile;
    return data;
  }
}
