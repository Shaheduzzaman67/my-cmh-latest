// class AppointmentListResp {
//   bool isSuccess;
//   List<AppointmentDataItem> data;

//   AppointmentListResp({this.isSuccess, this.data});

//   AppointmentListResp.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<AppointmentDataItem>();
//       json['data'].forEach((v) {
//         data.add(new AppointmentDataItem.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class AppointmentDataItem {
//   String patientId;
//   String patientName;
//   String workUnit;
//   String rank;
//   String patientRelation;
//   String appointmentNo;
//   String appointmentDate;
//   String visitingDept;
//   String visitingRoom;
//   String serialNo;
//   String roomNo;
//   String businessUnitNo;

//   AppointmentDataItem(
//       {this.patientId,
//         this.patientName,
//         this.workUnit,
//         this.rank,
//         this.patientRelation,
//         this.appointmentNo,
//         this.appointmentDate,
//         this.visitingDept,
//         this.visitingRoom,
//         this.serialNo,
//         this.roomNo,
//         this.businessUnitNo});

//   AppointmentDataItem.fromJson(Map<String, dynamic> json) {
//     patientId = json['patient_id'];
//     patientName = json['patient_name'];
//     workUnit = json['work_unit'];
//     rank = json['rank'];
//     patientRelation = json['patient_relation'];
//     appointmentNo = json['appointment_no'];
//     appointmentDate = json['appointment_date'];
//     visitingDept = json['visiting_dept'];
//     visitingRoom = json['visiting_room'];
//     serialNo = json['serial_no'];
//     roomNo = json['room_no'];
//     businessUnitNo = json['business_unit_no'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['patient_id'] = this.patientId;
//     data['patient_name'] = this.patientName;
//     data['work_unit'] = this.workUnit;
//     data['rank'] = this.rank;
//     data['patient_relation'] = this.patientRelation;
//     data['appointment_no'] = this.appointmentNo;
//     data['appointment_date'] = this.appointmentDate;
//     data['visiting_dept'] = this.visitingDept;
//     data['visiting_room'] = this.visitingRoom;
//     data['serial_no'] = this.serialNo;
//     data['room_no'] = this.roomNo;
//     data['business_unit_no'] = this.businessUnitNo;
//     return data;
//   }
// }
