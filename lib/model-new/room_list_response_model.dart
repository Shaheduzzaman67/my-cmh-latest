class RoomListResponseModel {
  bool? success;
  String? message;
  List<RoomList>? items;

  RoomListResponseModel({
    this.success,
    this.message,
    this.items,
  });

  factory RoomListResponseModel.fromJson(Map<String, dynamic> json) =>
      RoomListResponseModel(
        success: json["success"],
        message: json["message"],
        items: json["items"] == null
            ? []
            : List<RoomList>.from(
                json["items"]!.map((x) => RoomList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class RoomList {
  int? id;
  int? typeNo;
  String? typeId;
  String? typeDesc;
  int? roomNo;
  String? roomId;
  String? roomName;
  String? buildingId;
  String? buildingName;
  String? blockName;
  String? companyName;
  String? roomLocation;
  int? buNo;
  String? buName;
  int? activeStatus;
  int? onlineFlag;

  RoomList({
    this.id,
    this.typeNo,
    this.typeId,
    this.typeDesc,
    this.roomNo,
    this.roomId,
    this.roomName,
    this.buildingId,
    this.buildingName,
    this.blockName,
    this.companyName,
    this.roomLocation,
    this.buNo,
    this.buName,
    this.activeStatus,
    this.onlineFlag,
  });

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
        id: json["id"],
        typeNo: json["typeNo"],
        typeId: json["typeId"],
        typeDesc: json["typeDesc"],
        roomNo: json["roomNo"],
        roomId: json["roomId"],
        roomName: json["roomName"],
        buildingId: json["buildingId"],
        buildingName: json["buildingName"],
        blockName: json["blockName"],
        companyName: json["companyName"],
        roomLocation: json["roomLocation"],
        buNo: json["buNo"],
        buName: json["buName"],
        activeStatus: json["activeStatus"],
        onlineFlag: json["onlineFlag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeNo": typeNo,
        "typeId": typeId,
        "typeDesc": typeDesc,
        "roomNo": roomNo,
        "roomId": roomId,
        "roomName": roomName,
        "buildingId": buildingId,
        "buildingName": buildingName,
        "blockName": blockName,
        "companyName": companyName,
        "roomLocation": roomLocation,
        "buNo": buNo,
        "buName": buName,
        "activeStatus": activeStatus,
        "onlineFlag": onlineFlag,
      };
}
