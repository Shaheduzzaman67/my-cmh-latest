class InvestigationReportRequest {
  String? invoiceNo;
  String? testPerform;
  int? stampNo;

  InvestigationReportRequest({
    this.invoiceNo,
    this.testPerform,
    this.stampNo
  });

  InvestigationReportRequest.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['invoiceNo'];
    stampNo = json['stampNo'];
    testPerform = json['testPerform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceNo'] = this.invoiceNo;
    data['stampNo'] = this.stampNo;
    data['testPerform'] = this.testPerform;
    return data;
  }
}
