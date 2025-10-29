class GetAppointmentRequest {
  String? personalNumber;

  GetAppointmentRequest({
    this.personalNumber,
  });

  GetAppointmentRequest.fromJson(Map<String, dynamic> json) {
    personalNumber = json['personalNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalNumber'] = this.personalNumber;
    return data;
  }
}
