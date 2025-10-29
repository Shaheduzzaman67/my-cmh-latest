class CareOfRequest {
  String? personalNumber;
  String? serviceCategory;

  CareOfRequest({
    this.personalNumber,
    this.serviceCategory
  });

  CareOfRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['personalNumber'];
    serviceCategory = json['serviceCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalNumber'] = this.personalNumber;
    data['serviceCategory'] = this.serviceCategory;
    return data;
  }
}
