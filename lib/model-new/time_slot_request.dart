class TimeSlotRequest {
  int? roomNo;
  int? shiftdtlNo;
  String? slotDate;

  TimeSlotRequest({
    this.roomNo,
    this.shiftdtlNo,
    this.slotDate,
  });

  TimeSlotRequest.fromJson(Map<String, dynamic> json) {
    roomNo = json['roomNo'];
    shiftdtlNo = json['shiftdtlNo'];
    slotDate = json['slotDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomNo'] = this.roomNo;
    data['shiftdtlNo'] = this.shiftdtlNo;
    data['slotDate'] = this.slotDate;
    return data;
  }
}
