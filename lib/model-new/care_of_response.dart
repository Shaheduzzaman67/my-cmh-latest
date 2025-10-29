class CareOfResponse {
  CareOfResponse({
    this.success,
    this.info,
    this.warning,
    this.message,
    this.valid,
    this.id,
    this.model,
    this.items,
    this.obj,
  });

  bool? success;
  bool? info;
  bool? warning;
  dynamic message;
  bool? valid;
  dynamic id;
  dynamic model;
  dynamic items;
  Obj? obj;

  factory CareOfResponse.fromJson(Map<String, dynamic> json) => CareOfResponse(
        success: json["success"],
        info: json["info"],
        warning: json["warning"],
        message: json["message"],
        valid: json["valid"],
        id: json["id"],
        model: json["model"],
        items: json["items"],
        obj: Obj.fromJson(json["obj"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "info": info,
        "warning": warning,
        "message": message,
        "valid": valid,
        "id": id,
        "model": model,
        "items": items,
        "obj": obj!.toJson(),
      };
}

class Obj {
  Obj({
    this.patientInfo,
  });

  Info? patientInfo;

  factory Obj.fromJson(Map<String, dynamic> json) => Obj(
        patientInfo: Info.fromJson(json["patientInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "patientInfo": patientInfo!.toJson(),
      };
}

class Info {
  Info({
    this.id,
    this.hospitalNumber,
    this.activeStatus,
    this.persNumbPrefix,
    this.persNumbPrefixName,
    this.eligibilityStatus,
    this.eligibilityStatusName,
    this.serviceCategory,
    this.serviceCategoryName,
    this.personCategory,
    this.personCategoryName,
    this.rankNo,
    this.rankName,
    this.nationality,
    this.bloodGroup,
    this.identityMark,
    this.relationNo,
    this.fname,
    this.patientName,
    this.gender,
    this.genderData,
    this.maritalStatus,
    this.phoneMobile,
    this.email,
    this.address,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.passportNo,
    this.upazilaNo,
    this.upazilaName,
    this.corClientNo,
    this.extendedMonths,
    this.extendedYears,
    this.corClientCardNo,
    this.empNo,
    this.nokName,
    this.nokAddress,
    this.nokRelation,
    this.nokRelationName,
    this.nokContact,
    this.nationalId,
    this.religion,
    this.religionName,
    this.regType,
    this.personalNumber,
    this.serviceHolderId,
    this.presentAddress,
    this.presentDistrict,
    this.presentDistrictName,
    this.permanertAddress,
    this.permanentDistrict,
    this.permanentDistrictName,
    this.pastIllnessDate,
    this.pastIllnessDesc,
    this.pastIllnessDispose,
    this.personalId,
    this.deathFlag,
    this.corpsName,
    this.ssCreator,
    this.ssCreateSession,
    this.ssModifier,
    this.ssModifiedSession,
    this.companyNo,
    this.relationWithServiceHolder,
    this.mstatusData,
    this.photo,
  });

  int? id;
  dynamic hospitalNumber;
  int? activeStatus;
  int? persNumbPrefix;
  String? persNumbPrefixName;
  int? eligibilityStatus;
  dynamic eligibilityStatusName;
  int? serviceCategory;
  dynamic serviceCategoryName;
  int? personCategory;
  dynamic personCategoryName;
  int? rankNo;
  dynamic rankName;
  String? nationality;
  dynamic bloodGroup;
  dynamic identityMark;

  int? relationNo;
  String? fname;
  String? patientName;
  String? gender;
  String? genderData;
  String? maritalStatus;
  String? phoneMobile;
  String? email;
  dynamic address;
  dynamic fatherName;
  dynamic motherName;
  dynamic spouseName;
  dynamic passportNo;
  int? upazilaNo;
  dynamic upazilaName;
  int? corClientNo;
  int? extendedMonths;
  int? extendedYears;
  dynamic corClientCardNo;
  int? empNo;
  String? nokName;
  dynamic nokAddress;
  int? nokRelation;
  String? nokRelationName;
  String? nokContact;
  String? nationalId;
  int? religion;
  String? religionName;
  int? regType;
  String? personalNumber;
  dynamic serviceHolderId;
  String? presentAddress;
  dynamic presentDistrict;
  dynamic presentDistrictName;
  dynamic permanertAddress;
  dynamic permanentDistrict;
  dynamic permanentDistrictName;
  dynamic pastIllnessDate;
  dynamic pastIllnessDesc;
  dynamic pastIllnessDispose;
  String? personalId;
  dynamic deathFlag;
  dynamic corpsName;
  dynamic ssCreator;
  int? ssCreateSession;
  int? ssModifier;
  int? ssModifiedSession;
  int? companyNo;
  dynamic relationWithServiceHolder;

  String? mstatusData;
  String? photo;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        hospitalNumber: json["hospitalNumber"],
        activeStatus: json["activeStatus"],
        persNumbPrefix: json["persNumbPrefix"],
        persNumbPrefixName: json["persNumbPrefixName"],
        eligibilityStatus: json["eligibilityStatus"],
        eligibilityStatusName: json["eligibilityStatusName"],
        serviceCategory: json["serviceCategory"],
        serviceCategoryName: json["serviceCategoryName"],
        personCategory: json["personCategory"],
        personCategoryName: json["personCategoryName"],
        rankNo: json["rankNo"],
        rankName: json["rankName"],
        nationality: json["nationality"],
        bloodGroup: json["bloodGroup"],
        identityMark: json["identityMark"],
        relationNo: json["relationNo"],
        fname: json["fname"],
        patientName: json["patientName"],
        gender: json["gender"],
        genderData: json["genderData"],
        maritalStatus: json["maritalStatus"],
        phoneMobile: json["phoneMobile"],
        email: json["email"],
        address: json["address"],
        fatherName: json["fatherName"],
        motherName: json["motherName"],
        spouseName: json["spouseName"],
        passportNo: json["passportNo"],
        upazilaNo: json["upazilaNo"],
        upazilaName: json["upazilaName"],
        corClientNo: json["corClientNo"],
        extendedMonths: json["extendedMonths"],
        extendedYears: json["extendedYears"],
        corClientCardNo: json["corClientCardNo"],
        empNo: json["empNo"],
        nokName: json["nokName"],
        nokAddress: json["nokAddress"],
        nokRelation: json["nokRelation"],
        nokRelationName: json["nokRelationName"],
        nokContact: json["nokContact"],
        nationalId: json["nationalId"],
        religion: json["religion"],
        religionName: json["religionName"],
        regType: json["regType"],
        personalNumber: json["personalNumber"],
        serviceHolderId: json["serviceHolderId"],
        presentAddress: json["presentAddress"],
        presentDistrict: json["presentDistrict"],
        presentDistrictName: json["presentDistrictName"],
        permanertAddress: json["permanertAddress"],
        permanentDistrict: json["permanentDistrict"],
        permanentDistrictName: json["permanentDistrictName"],
        pastIllnessDate: json["pastIllnessDate"],
        pastIllnessDesc: json["pastIllnessDesc"],
        pastIllnessDispose: json["pastIllnessDispose"],
        personalId: json["personalId"],
        deathFlag: json["deathFlag"],
        corpsName: json["corpsName"],
        ssCreator: json["ssCreator"],
        ssCreateSession: json["ssCreateSession"],
        ssModifier: json["ssModifier"],
        ssModifiedSession: json["ssModifiedSession"],
        companyNo: json["companyNo"],
        relationWithServiceHolder: json["relationWithServiceHolder"],
        mstatusData: json["mstatusData"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalNumber": hospitalNumber,
        "activeStatus": activeStatus,
        "persNumbPrefix": persNumbPrefix,
        "persNumbPrefixName": persNumbPrefixName,
        "eligibilityStatus": eligibilityStatus,
        "eligibilityStatusName": eligibilityStatusName,
        "serviceCategory": serviceCategory,
        "serviceCategoryName": serviceCategoryName,
        "personCategory": personCategory,
        "personCategoryName": personCategoryName,
        "rankNo": rankNo,
        "rankName": rankName,
        "nationality": nationality,
        "bloodGroup": bloodGroup,
        "identityMark": identityMark,
        "relationNo": relationNo,
        "fname": fname,
        "patientName": patientName,
        "gender": gender,
        "genderData": genderData,
        "maritalStatus": maritalStatus,
        "phoneMobile": phoneMobile,
        "email": email,
        "address": address,
        "fatherName": fatherName,
        "motherName": motherName,
        "spouseName": spouseName,
        "passportNo": passportNo,
        "upazilaNo": upazilaNo,
        "upazilaName": upazilaName,
        "corClientNo": corClientNo,
        "extendedMonths": extendedMonths,
        "extendedYears": extendedYears,
        "corClientCardNo": corClientCardNo,
        "empNo": empNo,
        "nokName": nokName,
        "nokAddress": nokAddress,
        "nokRelation": nokRelation,
        "nokRelationName": nokRelationName,
        "nokContact": nokContact,
        "nationalId": nationalId,
        "religion": religion,
        "religionName": religionName,
        "regType": regType,
        "personalNumber": personalNumber,
        "serviceHolderId": serviceHolderId,
        "presentAddress": presentAddress,
        "presentDistrict": presentDistrict,
        "presentDistrictName": presentDistrictName,
        "permanertAddress": permanertAddress,
        "permanentDistrict": permanentDistrict,
        "permanentDistrictName": permanentDistrictName,
        "pastIllnessDate": pastIllnessDate,
        "pastIllnessDesc": pastIllnessDesc,
        "pastIllnessDispose": pastIllnessDispose,
        "personalId": personalId,
        "deathFlag": deathFlag,
        "corpsName": corpsName,
        "ssCreator": ssCreator,
        "ssCreateSession": ssCreateSession,
        "ssModifier": ssModifier,
        "ssModifiedSession": ssModifiedSession,
        "companyNo": companyNo,
        "relationWithServiceHolder": relationWithServiceHolder,
        "mstatusData": mstatusData,
        "photo": photo,
      };
}
