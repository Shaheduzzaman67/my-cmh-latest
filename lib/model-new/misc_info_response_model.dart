class MiscInfoResponseModel {
  bool? success;

  bool? warning;
  String? message;

  List<InfoItem>? items;

  MiscInfoResponseModel({
    this.success,
    this.warning,
    this.message,
    this.items,
  });

  factory MiscInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      MiscInfoResponseModel(
        success: json["success"],
        warning: json["warning"],
        message: json["message"],
        items: json["items"] == null
            ? []
            : List<InfoItem>.from(
                json["items"]!.map((x) => InfoItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "warning": warning,
        "message": message,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class InfoItem {
  int? miscellaneousNo;
  int? infoCategoryNo;

  String? infoName;
  String? infoMobile;
  String? infoBuilding;
  dynamic serviceDays;
  String? infoPlaceBn;
  String? ingoPlaceEn;
  dynamic infoAppointment;
  dynamic infoRank;
  dynamic department;
  dynamic ssUploadedOn;

  InfoItem({
    this.miscellaneousNo,
    this.infoCategoryNo,
    this.infoName,
    this.infoMobile,
    this.infoBuilding,
    this.serviceDays,
    this.infoPlaceBn,
    this.ingoPlaceEn,
    this.infoAppointment,
    this.infoRank,
    this.department,
    this.ssUploadedOn,
  });

  factory InfoItem.fromJson(Map<String, dynamic> json) => InfoItem(
        miscellaneousNo: json["miscellaneousNo"],
        infoCategoryNo: json["infoCategoryNo"],
        infoName: json["infoName"],
        infoMobile: json["infoMobile"],
        infoBuilding: json["infoBuilding"],
        serviceDays: json["serviceDays"],
        infoPlaceBn: json["infoPlaceBn"],
        ingoPlaceEn: json["ingoPlaceEn"],
        infoAppointment: json["infoAppointment"],
        infoRank: json["infoRank"],
        department: json["department"],
        ssUploadedOn: json["ssUploadedOn"],
      );

  Map<String, dynamic> toJson() => {
        "miscellaneousNo": miscellaneousNo,
        "infoCategoryNo": infoCategoryNo,
        "infoName": infoName,
        "infoMobile": infoMobile,
        "infoBuilding": infoBuilding,
        "serviceDays": serviceDays,
        "infoPlaceBn": infoPlaceBn,
        "ingoPlaceEn": ingoPlaceEn,
        "infoAppointment": infoAppointment,
        "infoRank": infoRank,
        "department": department,
        "ssUploadedOn": ssUploadedOn,
      };
}
