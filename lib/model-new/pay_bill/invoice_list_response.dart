class InvoiceListResponse {
  final bool? success;
  final String? message;
  final List<InvoiceItem>? items;

  InvoiceListResponse({
    this.success,
    this.message,
    this.items,
  });

  factory InvoiceListResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceListResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }
}

class InvoiceItem {
  final int? id;
  final int? regNo;
  final String? hospitalNumber;
  final String? personalNumber;
  final String? personalId;
  final dynamic rankNo;
  final dynamic rankName;
  final String? patientName;
  final String? gender;
  final String? phoneMobile;
  final int? invoiceNo;
  final String? invoiceId;
  final String? invoiceDate;
  final String? invoiceDatetime;
  final int? invoiceCancelFlag;
  final String? doctorId;
  final String? refDocName;
  final int? patTypeNo;
  final int? buNo;
  final int? empNo;
  final num? totalAmt;
  final num? totalBill;
  final num? totalPayAmt;
  final num? totalDiscAmt;
  final num? due;
  final String? ssCreatedOn;
  final int? ipdFlag;
  final dynamic fromDate;
  final dynamic toDate;
  final bool? dueFlag;
  final dynamic ipdSearchFlag;

  InvoiceItem({
    this.id,
    this.regNo,
    this.hospitalNumber,
    this.personalNumber,
    this.personalId,
    this.rankNo,
    this.rankName,
    this.patientName,
    this.gender,
    this.phoneMobile,
    this.invoiceNo,
    this.invoiceId,
    this.invoiceDate,
    this.invoiceDatetime,
    this.invoiceCancelFlag,
    this.doctorId,
    this.refDocName,
    this.patTypeNo,
    this.buNo,
    this.empNo,
    this.totalAmt,
    this.totalBill,
    this.totalPayAmt,
    this.totalDiscAmt,
    this.due,
    this.ssCreatedOn,
    this.ipdFlag,
    this.fromDate,
    this.toDate,
    this.dueFlag,
    this.ipdSearchFlag,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'] as int?,
      regNo: json['regNo'] as int?,
      hospitalNumber: json['hospitalNumber'] as String?,
      personalNumber: json['personalNumber'] as String?,
      personalId: json['personalId'] as String?,
      rankNo: json['rankNo'],
      rankName: json['rankName'],
      patientName: json['patientName'] as String?,
      gender: json['gender'] as String?,
      phoneMobile: json['phoneMobile'] as String?,
      invoiceNo: json['invoiceNo'] as int?,
      invoiceId: json['invoiceId'] as String?,
      invoiceDate: json['invoiceDate'] as String?,
      invoiceDatetime: json['invoiceDatetime'] as String?,
      invoiceCancelFlag: json['invoiceCancelFlag'] as int?,
      doctorId: json['doctorId'] as String?,
      refDocName: json['refDocName'] as String?,
      patTypeNo: json['patTypeNo'] as int?,
      buNo: json['buNo'] as int?,
      empNo: json['empNo'] as int?,
      totalAmt: json['totalAmt'],
      totalBill: json['totalBill'],
      totalPayAmt: json['totalPayAmt'],
      totalDiscAmt: json['totalDiscAmt'],
      due: json['due'],
      ssCreatedOn: json['ssCreatedOn'] as String?,
      ipdFlag: json['ipdFlag'] as int?,
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      dueFlag: json['dueFlag'] as bool?,
      ipdSearchFlag: json['ipdSearchFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'regNo': regNo,
      'hospitalNumber': hospitalNumber,
      'personalNumber': personalNumber,
      'personalId': personalId,
      'rankNo': rankNo,
      'rankName': rankName,
      'patientName': patientName,
      'gender': gender,
      'phoneMobile': phoneMobile,
      'invoiceNo': invoiceNo,
      'invoiceId': invoiceId,
      'invoiceDate': invoiceDate,
      'invoiceDatetime': invoiceDatetime,
      'invoiceCancelFlag': invoiceCancelFlag,
      'doctorId': doctorId,
      'refDocName': refDocName,
      'patTypeNo': patTypeNo,
      'buNo': buNo,
      'empNo': empNo,
      'totalAmt': totalAmt,
      'totalBill': totalBill,
      'totalPayAmt': totalPayAmt,
      'totalDiscAmt': totalDiscAmt,
      'due': due,
      'ssCreatedOn': ssCreatedOn,
      'ipdFlag': ipdFlag,
      'fromDate': fromDate,
      'toDate': toDate,
      'dueFlag': dueFlag,
      'ipdSearchFlag': ipdSearchFlag,
    };
  }
}
