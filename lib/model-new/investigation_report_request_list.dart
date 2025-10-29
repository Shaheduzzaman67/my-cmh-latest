class InvestigationReportListRequest {
  String? hospitalId;
  String? fromDate;
  String? toDate;

  InvestigationReportListRequest({
    this.hospitalId,
    this.fromDate,
    this.toDate
  });

  InvestigationReportListRequest.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospitalId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospitalId'] = this.hospitalId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
