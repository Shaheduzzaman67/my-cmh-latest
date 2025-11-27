class TimeSlotListResponseModel {
  bool? success;

  String? message;

  List<TimeSlotList>? timeSlotList;

  TimeSlotListResponseModel({this.success, this.message, this.timeSlotList});

  factory TimeSlotListResponseModel.fromJson(Map<String, dynamic> json) =>
      TimeSlotListResponseModel(
        success: json["success"],
        message: json["message"],
        timeSlotList: json["items"] == null
            ? []
            : List<TimeSlotList>.from(
                json["items"]!.map((x) => TimeSlotList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "items": timeSlotList == null
        ? []
        : List<dynamic>.from(timeSlotList!.map((x) => x.toJson())),
  };
}

class TimeSlotList {
  int? slotNo;
  String? slotDate;

  int? slotSl;

  String? startTime;
  String? endTime;

  int? durationMin;

  dynamic appointNo;

  String? bookedBy;
  dynamic appointStatus;
  int? retainFlag;
  int? shiftOrder;
  int? roomNo;
  String? description;
  int? isOnline;
  String? allocationName;

  TimeSlotList({
    this.slotNo,
    this.slotDate,
    this.slotSl,
    this.startTime,
    this.endTime,
    this.durationMin,
    this.appointNo,
    this.bookedBy,
    this.appointStatus,
    this.retainFlag,
    this.shiftOrder,
    this.roomNo,
    this.description,
    this.isOnline,
    this.allocationName,
  });

  factory TimeSlotList.fromJson(Map<String, dynamic> json) => TimeSlotList(
    slotNo: json["slotNo"],
    slotDate: json["slotDate"],
    slotSl: json["slotSl"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    durationMin: json["durationMin"],
    appointNo: json["appointNo"],
    bookedBy: json["bookedBy"],
    appointStatus: json["appointStatus"],
    retainFlag: json["retainFlag"],
    shiftOrder: json["shiftOrder"],
    description: json["description"],
    roomNo: json["roomNo"],
    isOnline: json["isOnline"],
    allocationName: json["allocationName"],
  );

  Map<String, dynamic> toJson() => {
    "slotNo": slotNo,
    "slotDate": slotDate,
    "slotSl": slotSl,
    "startTime": startTime,
    "endTime": endTime,
    "durationMin": durationMin,
    "appointNo": appointNo,
    "bookedBy": bookedBy,
    "appointStatus": appointStatus,
    "retainFlag": retainFlag,
    "shiftOrder": shiftOrder,
    "description": description,
    "roomNo": roomNo,
    "isOnline": isOnline,
    "allocationName": allocationName,
  };
}
