class AdmissionBillRequest {
  int? admissionNo;
  String? payAmt;
  String? orderId;
  String? remarks;

  AdmissionBillRequest({
    this.admissionNo,
    this.payAmt,
    this.orderId,
    this.remarks,
  });

  AdmissionBillRequest.fromJson(Map<String, dynamic> json) {
    admissionNo = json['admissionNo'];
    payAmt = json['payAmt'];
    orderId = json['order_id'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admissionNo'] = this.admissionNo;
    data['payAmt'] = this.payAmt;
    data['order_id'] = this.orderId;
    data['remarks'] = this.remarks;
    return data;
  }
}
