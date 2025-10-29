class RemoveAccountRequest {
  String? personalNumber;
 

  RemoveAccountRequest({
    this.personalNumber,
   
  });

  RemoveAccountRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.personalNumber;
    return data;
  }
}
