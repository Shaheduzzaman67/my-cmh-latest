// class MedicineRequest {
//   String email;
//   String phone;
//   String deliveryLocation;
//   String prescriptionId;
//   List<String> medicines;
//   String notes;
//   int deliveryCharge;

//   MedicineRequest(
//       {this.email,
//         this.phone,
//         this.deliveryLocation,
//         this.prescriptionId,
//         this.medicines,
//         this.notes,
//         this.deliveryCharge});

//   MedicineRequest.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     phone = json['phone'];
//     deliveryLocation = json['delivery_location'];
//     prescriptionId = json['prescription_id'];
//     medicines = json['medicines'].cast<String>();
//     notes = json['notes'];
//     deliveryCharge = json['delivery_charge'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['delivery_location'] = this.deliveryLocation;
//     data['prescription_id'] = this.prescriptionId;
//     data['medicines'] = this.medicines;
//     data['notes'] = this.notes;
//     data['delivery_charge'] = this.deliveryCharge;
//     return data;
//   }
// }
