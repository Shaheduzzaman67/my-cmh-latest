class AppointmentRequest {
  String? patientName;
  String? personalNumber;
  int? departmentNo;
  String? chifComplain;
  String? chiefComplaints;
  String? appointmentDate;
  int? shiftDetailNo;
  int? consulationType;
  int? slotNo;
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
  int? roomNo;
  String? roomDesc;
  String? startTime;
  String? endTime;

  AppointmentRequest({
    this.patientName,
    this.personalNumber,
    this.departmentNo,
    this.chifComplain,
    this.chiefComplaints,
    this.appointmentDate,
    this.shiftDetailNo,
    this.consulationType,
    this.doctorNo,
    this.slotNo,
    this.priorityNo,
    this.priorityDesc,
    this.registrationNo,
    this.gender,
    this.maritalStatus,
    this.email,
    this.bloodGroup,
    this.mobileNumber,
    this.multiAppointment,
    this.roomNo,
    this.roomDesc,
    this.startTime,
    this.endTime,
  });

  AppointmentRequest.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    personalNumber = json['personalNumber'];
    departmentNo = json['departmentNo'];
    chifComplain = json['chifComplain'];
    chiefComplaints = json['chiefComplaints'];
    appointmentDate = json['appointmentDate'];
    shiftDetailNo = json['shiftDetailNo'];
    consulationType = json['consulationType'];
    doctorNo = json['doctorNo'];
    priorityNo = json['priorityNo'];
    priorityDesc = json['priorityDesc'];
    registrationNo = json['registrationNo'];
    gender = json['gender'];
    maritalStatus = json['maritalStatus'];
    email = json['email'];
    slotNo = json['slotNo'];
    bloodGroup = json['bloodGroup'];
    mobileNumber = json['mobileNumber'];
    multiAppointment = json['multiAppointment'];
    roomNo = json['roomNo'];
    roomDesc = json['roomDesc'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientName'] = this.patientName;
    data['personalNumber'] = this.personalNumber;
    data['departmentNo'] = this.departmentNo;
    data['chifComplain'] = this.chifComplain;
    data['chiefComplaints'] = this.chiefComplaints;
    data['appointmentDate'] = this.appointmentDate;
    data['shiftDetailNo'] = this.shiftDetailNo;
    data['consulationType'] = this.consulationType;
    data['doctorNo'] = this.doctorNo;
    data['priorityNo'] = this.priorityNo;
    data['priorityDesc'] = this.priorityDesc;
    data['registrationNo'] = this.registrationNo;
    data['gender'] = this.gender;
    data['maritalStatus'] = this.maritalStatus;
    data['email'] = this.email;
    data['slotNo'] = this.slotNo;
    data['bloodGroup'] = this.bloodGroup;
    data['mobileNumber'] = this.mobileNumber;
    data['multiAppointment'] = this.multiAppointment;
    data['roomNo'] = this.roomNo;
    data['roomDesc'] = this.roomDesc;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
