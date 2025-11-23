class ForgotPassReq {
  String? personalId;
  String? dob;

  ForgotPassReq({this.personalId, this.dob});

  ForgotPassReq.fromJson(Map<String, dynamic> json) {
    personalId = json['userName'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.personalId;
    data['dob'] = this.dob;

    return data;
  }
}
