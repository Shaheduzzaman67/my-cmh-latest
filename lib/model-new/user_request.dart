class UserRequest {
  String? personalNumber;

  UserRequest({
    this.personalNumber,
  });

  UserRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['personalNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalNumber'] = this.personalNumber;
    return data;
  }
}
