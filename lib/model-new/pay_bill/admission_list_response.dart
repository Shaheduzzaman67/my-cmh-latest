class AdmissionListResponse {
  final bool? success;
  final String? message;
  final List<AdmissionItem>? items;
  final dynamic obj;

  AdmissionListResponse({
    this.success,
    this.message,
    this.items,
    this.obj,
  });

  factory AdmissionListResponse.fromJson(Map<String, dynamic> json) {
    return AdmissionListResponse(
      success: json['success'],
      message: json['message'],
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdmissionItem.fromJson(e))
          .toList(),
      obj: json['obj'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (success != null) data['success'] = success;
    if (message != null) data['message'] = message;
    if (items != null) data['items'] = items!.map((e) => e.toJson()).toList();
    if (obj != null) data['obj'] = obj;
    return data;
  }
}

class AdmissionItem {
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

  AdmissionItem({
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
  });

  factory AdmissionItem.fromJson(Map<String, dynamic> json) {
    return AdmissionItem(
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
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (admissionId != null) data['admissionId'] = admissionId;
    if (admissionDate != null) data['admissionDate'] = admissionDate;
    if (admissionDateTime != null)
      data['admissionDateTime'] = admissionDateTime!.toIso8601String();
    if (regNo != null) data['regNo'] = regNo;
    if (hospitalId != null) data['hospitalId'] = hospitalId;
    if (patientName != null) data['patientName'] = patientName;
    if (age != null) data['age'] = age;
    if (gender != null) data['gender'] = gender;
    if (wardName != null) data['wardName'] = wardName;
    return data;
  }
}
