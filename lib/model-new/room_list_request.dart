class RoomListRequest {
  String? departmentNo;

  RoomListRequest({
    this.departmentNo,
  });

  RoomListRequest.fromJson(Map<String, dynamic> json) {
    departmentNo = json['departmentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentNo'] = this.departmentNo;
    return data;
  }
}
