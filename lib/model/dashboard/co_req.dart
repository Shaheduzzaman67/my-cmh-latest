// class CoReq {
//   String email;
//   String phoneNo;
//   bool fever;
//   bool cough;
//   bool breathingDifficulty;
//   bool tiredness;
//   bool aches;
//   bool soreThroat;

//   CoReq(
//       {this.email,
//         this.phoneNo,
//         this.fever,
//         this.cough,
//         this.breathingDifficulty,
//         this.tiredness,
//         this.aches,
//         this.soreThroat});

//   CoReq.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     phoneNo = json['phone_no'];
//     fever = json['fever'];
//     cough = json['cough'];
//     breathingDifficulty = json['breathing_difficulty'];
//     tiredness = json['tiredness'];
//     aches = json['aches'];
//     soreThroat = json['sore_throat'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['phone_no'] = this.phoneNo;
//     data['fever'] = this.fever;
//     data['cough'] = this.cough;
//     data['breathing_difficulty'] = this.breathingDifficulty;
//     data['tiredness'] = this.tiredness;
//     data['aches'] = this.aches;
//     data['sore_throat'] = this.soreThroat;
//     return data;
//   }
// }
