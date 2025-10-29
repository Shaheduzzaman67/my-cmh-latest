class CancelRequest {
  int? appointmentNo;
  String? cencelReason;
  int? cencelType;

  CancelRequest({
    this.appointmentNo,
    this.cencelReason,
    this.cencelType,
  });

  CancelRequest.fromJson(Map<String, dynamic> json) {
    appointmentNo = json['appointmentNo'];
    cencelReason = json['cencelReason'];
    cencelType = json['cencelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentNo'] = this.appointmentNo;
    data['cencelReason'] = this.cencelReason;
    data['cencelType'] = this.cencelType;
    return data;
  }
}
