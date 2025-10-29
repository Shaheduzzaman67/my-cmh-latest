// class TeleMedicineListResp {
//   bool isSuccess;
//   List<TeleData> data;

//   TeleMedicineListResp({this.isSuccess, this.data});

//   TeleMedicineListResp.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<TeleData>();
//       json['data'].forEach((v) {
//         data.add(new TeleData.fromJson(v));
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

// class TeleData {
//   int id;
//   String doctorName;
//   String deptType;
//   String doctorDepartment;
//   String doctorMobile;
//   int doctorSchedule;
//   String fromTime;
//   String toTime;

//   TeleData(
//       {this.id,
//         this.doctorName,
//         this.deptType,
//         this.doctorDepartment,
//         this.doctorMobile,
//         this.doctorSchedule,
//         this.fromTime,
//         this.toTime});

//   TeleData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     doctorName = json['doctor_name'];
//     deptType = json['dept_type'];
//     doctorDepartment = json['doctor_department'];
//     doctorMobile = json['doctor_mobile'];
//     doctorSchedule = json['doctor_schedule'];
//     fromTime = json['from_time'];
//     toTime = json['to_time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['doctor_name'] = this.doctorName;
//     data['dept_type'] = this.deptType;
//     data['doctor_department'] = this.doctorDepartment;
//     data['doctor_mobile'] = this.doctorMobile;
//     data['doctor_schedule'] = this.doctorSchedule;
//     data['from_time'] = this.fromTime;
//     data['to_time'] = this.toTime;
//     return data;
//   }
// }
