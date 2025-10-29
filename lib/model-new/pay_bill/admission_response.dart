class AppointmentSummeryResponse {
  final bool? success;

  final String? message;

  final Model? model;

  AppointmentSummeryResponse({
    this.success,
    this.message,
    this.model,
  });

  factory AppointmentSummeryResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentSummeryResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      model: json['model'] != null ? Model.fromJson(json['model']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'model': model?.toJson(),
    };
  }
}

class Model {
  final BillSummary? billSummary;
  final List<HeadWiseTotalBill>? headWiseTotalBillList;
  final PatientInfo? patientInfo;

  Model({
    this.billSummary,
    this.headWiseTotalBillList,
    this.patientInfo,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      billSummary: json['billSummary'] != null
          ? BillSummary.fromJson(json['billSummary'])
          : null,
      headWiseTotalBillList: (json['headWiseTotalBillList'] as List<dynamic>?)
          ?.map((e) => HeadWiseTotalBill.fromJson(e))
          .toList(),
      patientInfo: json['patientInfo'] != null
          ? PatientInfo.fromJson(json['patientInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billSummary': billSummary?.toJson(),
      'headWiseTotalBillList':
          headWiseTotalBillList?.map((e) => e.toJson()).toList(),
      'patientInfo': patientInfo?.toJson(),
    };
  }
}

class BillSummary {
  final int? admissionNo;
  final double? totalBill;
  final double? totalDiscount;
  final double? netBill;
  final double? totalCollection;
  final double? totalRefund;
  final double? netCollection;
  final double? due;
  final double? bills;
  final double? billsReturn;
  final double? initialCollection;
  final double? dueCollection;
  final double? refund;
  final double? initialDiscount;
  final double? secondDiscount;
  final double? initialDiscountReturn;
  final double? secondDiscountReturn;
  final double? vat;
  final double? vatReturn;
  final double? urgentFee;
  final double? urgentFeeReturn;
  final double? serviceCharge;
  final double? serviceChargeReturn;
  final int? icuFlag;
  final double? advance;
  final double? deposit;
  final double? settlement;
  final double? depositAmt;
  final double? dueAmt;
  final double? refundableAmt;
  final double? netBillInWard;

  BillSummary({
    this.admissionNo,
    this.totalBill,
    this.totalDiscount,
    this.netBill,
    this.totalCollection,
    this.totalRefund,
    this.netCollection,
    this.due,
    this.bills,
    this.billsReturn,
    this.initialCollection,
    this.dueCollection,
    this.refund,
    this.initialDiscount,
    this.secondDiscount,
    this.initialDiscountReturn,
    this.secondDiscountReturn,
    this.vat,
    this.vatReturn,
    this.urgentFee,
    this.urgentFeeReturn,
    this.serviceCharge,
    this.serviceChargeReturn,
    this.icuFlag,
    this.advance,
    this.deposit,
    this.settlement,
    this.depositAmt,
    this.dueAmt,
    this.refundableAmt,
    this.netBillInWard,
  });

  factory BillSummary.fromJson(Map<String, dynamic> json) {
    return BillSummary(
      admissionNo: json['admissionNo'] as int?,
      totalBill: (json['totalBill'] as num?)?.toDouble(),
      totalDiscount: (json['totalDiscount'] as num?)?.toDouble(),
      netBill: (json['netBill'] as num?)?.toDouble(),
      totalCollection: (json['totalCollection'] as num?)?.toDouble(),
      totalRefund: (json['totalRefund'] as num?)?.toDouble(),
      netCollection: (json['netCollection'] as num?)?.toDouble(),
      due: (json['due'] as num?)?.toDouble(),
      bills: (json['bills'] as num?)?.toDouble(),
      billsReturn: (json['billsReturn'] as num?)?.toDouble(),
      initialCollection: (json['initialCollection'] as num?)?.toDouble(),
      dueCollection: (json['dueCollection'] as num?)?.toDouble(),
      refund: (json['refund'] as num?)?.toDouble(),
      initialDiscount: (json['initialDiscount'] as num?)?.toDouble(),
      secondDiscount: (json['secondDiscount'] as num?)?.toDouble(),
      initialDiscountReturn:
          (json['initialDiscountReturn'] as num?)?.toDouble(),
      secondDiscountReturn: (json['secondDiscountReturn'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      vatReturn: (json['vatReturn'] as num?)?.toDouble(),
      urgentFee: (json['urgentFee'] as num?)?.toDouble(),
      urgentFeeReturn: (json['urgentFeeReturn'] as num?)?.toDouble(),
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble(),
      serviceChargeReturn: (json['serviceChargeReturn'] as num?)?.toDouble(),
      icuFlag: json['icuFlag'] as int?,
      advance: (json['advance'] as num?)?.toDouble(),
      deposit: (json['deposit'] as num?)?.toDouble(),
      settlement: (json['settlement'] as num?)?.toDouble(),
      depositAmt: (json['depositAmt'] as num?)?.toDouble(),
      dueAmt: (json['dueAmt'] as num?)?.toDouble(),
      refundableAmt: (json['refundableAmt'] as num?)?.toDouble(),
      netBillInWard: (json['netBillInWard'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admissionNo': admissionNo,
      'totalBill': totalBill,
      'totalDiscount': totalDiscount,
      'netBill': netBill,
      'totalCollection': totalCollection,
      'totalRefund': totalRefund,
      'netCollection': netCollection,
      'due': due,
      'bills': bills,
      'billsReturn': billsReturn,
      'initialCollection': initialCollection,
      'dueCollection': dueCollection,
      'refund': refund,
      'initialDiscount': initialDiscount,
      'secondDiscount': secondDiscount,
      'initialDiscountReturn': initialDiscountReturn,
      'secondDiscountReturn': secondDiscountReturn,
      'vat': vat,
      'vatReturn': vatReturn,
      'urgentFee': urgentFee,
      'urgentFeeReturn': urgentFeeReturn,
      'serviceCharge': serviceCharge,
      'serviceChargeReturn': serviceChargeReturn,
      'icuFlag': icuFlag,
      'advance': advance,
      'deposit': deposit,
      'settlement': settlement,
      'depositAmt': depositAmt,
      'dueAmt': dueAmt,
      'refundableAmt': refundableAmt,
      'netBillInWard': netBillInWard,
    };
  }
}

class HeadWiseTotalBill {
  final int? id;
  final int? admissionNo;
  final String? headName;
  final double? totalAmount;
  final String? admissionDate;
  final dynamic disDate;
  final int? stayInDay;
  final int? headNo;

  HeadWiseTotalBill({
    this.id,
    this.admissionNo,
    this.headName,
    this.totalAmount,
    this.admissionDate,
    this.disDate,
    this.stayInDay,
    this.headNo,
  });

  factory HeadWiseTotalBill.fromJson(Map<String, dynamic> json) {
    return HeadWiseTotalBill(
      id: json['id'] as int?,
      admissionNo: json['admissionNo'] as int?,
      headName: json['headName'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      admissionDate: json['admissionDate'] as String?,
      disDate: json['disDate'],
      stayInDay: json['stayInDay'] as int?,
      headNo: json['headNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admissionNo': admissionNo,
      'headName': headName,
      'totalAmount': totalAmount,
      'admissionDate': admissionDate,
      'disDate': disDate,
      'stayInDay': stayInDay,
      'headNo': headNo,
    };
  }
}

class PatientInfo {
  final int? id;
  final String? admissionId;
  final String? admissionDate;
  final DateTime? admissionDateTime;
  final int? regNo;
  final String? hospitalId;
  final String? patientName;
  final String? age;
  final String? gender;
  final String? wardName;
  final String? phoneMobile;
  final String? patientAddress;
  final String? unitName;

  PatientInfo({
    this.id,
    this.admissionId,
    this.admissionDate,
    this.admissionDateTime,
    this.regNo,
    this.hospitalId,
    this.patientName,
    this.age,
    this.gender,
    this.wardName,
    this.phoneMobile,
    this.patientAddress,
    this.unitName,
  });

  factory PatientInfo.fromJson(Map<String, dynamic> json) => PatientInfo(
        id: json['id'],
        admissionId: json['admissionId'],
        admissionDate: json['admissionDate'],
        admissionDateTime: json['admissionDateTime'] != null
            ? DateTime.tryParse(json['admissionDateTime'])
            : null,
        regNo: json['regNo'],
        hospitalId: json['hospitalId'],
        patientName: json['patientName'],
        age: json['age'],
        gender: json['gender'],
        wardName: json['wardName'],
        phoneMobile: json['phoneMobile'],
        patientAddress: json['patientAddress'],
        unitName: json['unitName'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admissionId": admissionId,
        "admissionDate": admissionDate,
        "admissionDateTime": admissionDateTime,
        "regNo": regNo,
        "hospitalId": hospitalId,
        "patientName": patientName,
        "age": age,
        "gender": gender,
        "wardName": wardName,
        "phoneMobile": phoneMobile,
        "patientAddress": patientAddress,
        "unitName": unitName,
      };
}
