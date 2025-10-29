// class LabReportListResp {
//   bool isSuccess;
//   List<LabReportData> data;

//   LabReportListResp({this.isSuccess, this.data});

//   LabReportListResp.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<LabReportData>();
//       json['data'].forEach((v) {
//         data.add(new LabReportData.fromJson(v));
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

// class LabReportData {
//   String report_id;
//   String prescription_no;
//   String test_name;
//   String department;

//   LabReportData(
//       {this.report_id,
//         this.prescription_no,
//         this.test_name,
//         this.department,
//        });

//   LabReportData.fromJson(Map<String, dynamic> json) {
//     report_id = json['report_id'];
//     prescription_no = json['prescription_no'];
//     test_name = json['test_name'];
//     department = json['department'];

//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['report_id'] = this.report_id;
//     data['prescription_no'] = this.prescription_no;
//     data['test_name'] = this.test_name;
//     data['department'] = this.department;

//     return data;
//   }
// }
