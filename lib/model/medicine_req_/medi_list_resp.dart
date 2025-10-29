// class MedicineListResponse {
//   bool isSuccess;
//   Data data;

//   MedicineListResponse({this.isSuccess, this.data});

//   MedicineListResponse.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String prescriptionId;
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
//   List<Medicine> medicine;
//   List<Null> investigation;
//   List<String> chiefComplain;
//   List<Null> pastIllness;
//   List<String> disease;
//   List<String> advise;
//   List<String> disposal;

//   Data(
//       {this.prescriptionId,
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
//         this.medicine,
//         this.investigation,
//         this.chiefComplain,
//         this.pastIllness,
//         this.disease,
//         this.advise,
//         this.disposal});

//   Data.fromJson(Map<String, dynamic> json) {
//     prescriptionId = json['prescription_id'];
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
//     if (json['medicine'] != null) {
//       medicine = new List<Medicine>();
//       json['medicine'].forEach((v) {
//         medicine.add(new Medicine.fromJson(v));
//       });
//     }

//     chiefComplain = json['chief_complain'].cast<String>();

//     disease = json['disease'].cast<String>();
//     advise = json['advise'].cast<String>();
//     disposal = json['disposal'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prescription_id'] = this.prescriptionId;
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
//     if (this.medicine != null) {
//       data['medicine'] = this.medicine.map((v) => v.toJson()).toList();
//     }

//     data['chief_complain'] = this.chiefComplain;

//     data['disease'] = this.disease;
//     data['advise'] = this.advise;
//     data['disposal'] = this.disposal;
//     return data;
//   }
// }

// class Medicine {
//   String medicine;
//   String dosage;
//   String genericName;

//   Medicine({this.medicine, this.dosage, this.genericName});

//   Medicine.fromJson(Map<String, dynamic> json) {
//     medicine = json['medicine'];
//     dosage = json['dosage'];
//     genericName = json['generic_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['medicine'] = this.medicine;
//     data['dosage'] = this.dosage;
//     data['generic_name'] = this.genericName;
//     return data;
//   }
// }
