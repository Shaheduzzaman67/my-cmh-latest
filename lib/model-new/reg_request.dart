class RegRequest {
  String? userName;
  String? password;
  String? dob;
  String? mobile;
  String? email;

  RegRequest({this.userName, this.password, this.dob, this.mobile, this.email});

  RegRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    dob = json['dob'];
    mobile = json['phoneMobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['dob'] = this.dob;
    data['phoneMobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
