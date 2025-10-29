class OpdListRequest {
  String? regNo;

  OpdListRequest({
    this.regNo,
  });

  OpdListRequest.fromJson(Map<String, dynamic> json) {
    regNo = json['regNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regNo'] = this.regNo;
    return data;
  }
}
