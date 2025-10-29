// import 'lab_report_resp.dart';

// class PresListResp {
//   bool isSuccess;
//   List<PrescriptionData> data;

//   PresListResp({this.isSuccess, this.data});

//   PresListResp.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<PrescriptionData>();
//       json['data'].forEach((v) {
//         data.add(new PrescriptionData.fromJson(v));
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

// class PrescriptionData {
//   String prescriptionId;
//   String consultantNo;
//   String consultantId;
//   String prescriptionDate;
//   String name;
//   String personalId;
//   String departmentName;
//   String roomName;
//   String unit;
//   String rank;
//   String genderData;
//   String age;
//   String bloodGroup;
//   String doctor;
//   bool isExpanded = false;
//   bool isDataLoaded = false;
//   List<LabReportData> labData = [];

//   PrescriptionData(
//       {this.prescriptionId,
//         this.consultantNo,
//         this.consultantId,
//         this.prescriptionDate,
//         this.name,
//         this.personalId,
//         this.departmentName,
//         this.roomName,
//         this.unit,
//         this.rank,
//         this.genderData,
//         this.age,
//         this.bloodGroup,
//         this.doctor});

//   PrescriptionData.fromJson(Map<String, dynamic> json) {
//     prescriptionId = json['prescription_id'];
//     consultantNo = json['consultant_no'];
//     consultantId = json['consultant_id'];
//     prescriptionDate = json['prescription_date'];
//     name = json['name'];
//     personalId = json['personal_id'];
//     departmentName = json['department_name'];
//     roomName = json['room_name'];
//     unit = json['unit'];
//     rank = json['rank'];
//     genderData = json['gender_data'];
//     age = json['age'];
//     bloodGroup = json['blood_group'];
//     doctor = json['doctor'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prescription_id'] = this.prescriptionId;
//     data['consultant_no'] = this.consultantNo;
//     data['consultant_id'] = this.consultantId;
//     data['prescription_date'] = this.prescriptionDate;
//     data['name'] = this.name;
//     data['personal_id'] = this.personalId;
//     data['department_name'] = this.departmentName;
//     data['room_name'] = this.roomName;
//     data['unit'] = this.unit;
//     data['rank'] = this.rank;
//     data['gender_data'] = this.genderData;
//     data['age'] = this.age;
//     data['blood_group'] = this.bloodGroup;
//     data['doctor'] = this.doctor;
//     return data;
//   }
// }
