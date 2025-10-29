class CreateAppointmentRequest {
  CreateAppointmentRequest({
    this.patientName,
    this.personalNumber,
    this.departmentNo,
    this.roomNo,
    this.roomDesc,
    this.chifComplain,
    this.chiefComplaints,
    this.appointmentDate,
    this.slotSl,
    this.shiftDetailNo,
    this.consulationType,
    this.doctorNo,
    this.priorityNo,
    this.priorityDesc,
    this.registrationNo,
    this.gender,
    this.maritalStatus,
    this.email,
    this.bloodGroup,
    this.mobileNumber,
    this.multiAppointment,
  });

  String? patientName;
  String? personalNumber;
  int? departmentNo;
  int? roomNo;
  String? roomDesc;
  String? chifComplain;
  String? chiefComplaints;
  DateTime? appointmentDate;
  int? slotSl;
  int? shiftDetailNo;
  int? consulationType;
  int? doctorNo;
  int? priorityNo;
  String? priorityDesc;
  int? registrationNo;
  String? gender;
  dynamic maritalStatus;
  String? email;
  String? bloodGroup;
  String? mobileNumber;
  bool? multiAppointment;

  factory CreateAppointmentRequest.fromJson(Map<String, dynamic> json) =>
      CreateAppointmentRequest(
        patientName: json["patientName"],
        personalNumber: json["personalNumber"],
        departmentNo: json["departmentNo"],
        roomNo: json["roomNo"],
        roomDesc: json["roomDesc"],
        chifComplain: json["chifComplain"],
        chiefComplaints: json["chiefComplaints"],
        appointmentDate: DateTime.parse(json["appointmentDate"]),
        slotSl: json["slotSl"],
        shiftDetailNo: json["shiftDetailNo"],
        consulationType: json["consulationType"],
        doctorNo: json["doctorNo"],
        priorityNo: json["priorityNo"],
        priorityDesc: json["priorityDesc"],
        registrationNo: json["registrationNo"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        email: json["email"],
        bloodGroup: json["bloodGroup"],
        mobileNumber: json["mobileNumber"],
        multiAppointment: json["multiAppointment"],
      );

  Map<String, dynamic> toJson() => {
        "patientName": patientName,
        "personalNumber": personalNumber,
        "departmentNo": departmentNo,
        "roomNo": roomNo,
        "roomDesc": roomDesc,
        "chifComplain": chifComplain,
        "chiefComplaints": chiefComplaints,
        "appointmentDate": appointmentDate?.toIso8601String(),
        "slotSl": slotSl,
        "shiftDetailNo": shiftDetailNo,
        "consulationType": consulationType,
        "doctorNo": doctorNo,
        "priorityNo": priorityNo,
        "priorityDesc": priorityDesc,
        "registrationNo": registrationNo,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "email": email,
        "bloodGroup": bloodGroup,
        "mobileNumber": mobileNumber,
        "multiAppointment": multiAppointment,
      };
}
