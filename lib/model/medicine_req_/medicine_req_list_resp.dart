// class MedicineRequestListResponse {
//   bool isSuccess;
//   List<MData> data;

//   MedicineRequestListResponse({this.isSuccess, this.data});

//   MedicineRequestListResponse.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<MData>();
//       json['data'].forEach((v) {
//         data.add(new MData.fromJson(v));
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

// class MData {
//   int id;
//   String personalId;
//   String email;
//   String phone;
//   String prescriptionId;
//   String deliveryLocation;
//   String notes;
//   String createdAt;
//   List<Medicines> medicines;
//   DeliveryManInfo deliveryManInfo;
//   OrderProgressStatus orderProgressStatus;
//   bool isExpanded = true;

//   MData(
//       {this.id,
//         this.personalId,
//         this.email,
//         this.phone,
//         this.prescriptionId,
//         this.deliveryLocation,
//         this.notes,
//         this.createdAt,
//         this.medicines,
//         this.deliveryManInfo,
//         this.orderProgressStatus});

//   MData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     personalId = json['personal_id'];
//     email = json['email'];
//     phone = json['phone'];
//     prescriptionId = json['prescription_id'];
//     deliveryLocation = json['delivery_location'];
//     notes = json['notes'];
//     createdAt = json['created_at'];
//     if (json['medicines'] != null) {
//       medicines = new List<Medicines>();
//       json['medicines'].forEach((v) {
//         medicines.add(new Medicines.fromJson(v));
//       });
//     }
//     deliveryManInfo = json['delivery_man_info'] != null
//         ? new DeliveryManInfo.fromJson(json['delivery_man_info'])
//         : null;
//     orderProgressStatus = json['order_progress_Status'] != null
//         ? new OrderProgressStatus.fromJson(json['order_progress_Status'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['personal_id'] = this.personalId;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['prescription_id'] = this.prescriptionId;
//     data['delivery_location'] = this.deliveryLocation;
//     data['notes'] = this.notes;
//     data['created_at'] = this.createdAt;
//     if (this.medicines != null) {
//       data['medicines'] = this.medicines.map((v) => v.toJson()).toList();
//     }
//     if (this.deliveryManInfo != null) {
//       data['delivery_man_info'] = this.deliveryManInfo.toJson();
//     }
//     if (this.orderProgressStatus != null) {
//       data['order_progress_Status'] = this.orderProgressStatus.toJson();
//     }
//     return data;
//   }
// }

// class Medicines {
//   int id;
//   String name;
//   int medicineRequestId;

//   Medicines({this.id, this.name, this.medicineRequestId});

//   Medicines.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     medicineRequestId = json['medicine_request_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['medicine_request_id'] = this.medicineRequestId;
//     return data;
//   }
// }

// class DeliveryManInfo {
//   int id;
//   int adminId;
//   String name;
//   String email;
//   String phone;
//   String createdAt;

//   DeliveryManInfo(
//       {this.id,
//         this.adminId,
//         this.name,
//         this.email,
//         this.phone,
//         this.createdAt});

//   DeliveryManInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     adminId = json['admin_id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['admin_id'] = this.adminId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

// class OrderProgressStatus {
//   int id;
//   String title;
//   String type;

//   OrderProgressStatus({this.id, this.title, this.type});

//   OrderProgressStatus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['type'] = this.type;
//     return data;
//   }
// }
