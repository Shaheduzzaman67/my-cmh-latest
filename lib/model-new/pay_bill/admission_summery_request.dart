class AdmissionSummeryRequest {
  String? admissionNo;

  AdmissionSummeryRequest({
    this.admissionNo,
  });

  AdmissionSummeryRequest.fromJson(Map<String, dynamic> json) {
    admissionNo = json['admissionNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admissionNo'] = this.admissionNo;
    return data;
  }
}
