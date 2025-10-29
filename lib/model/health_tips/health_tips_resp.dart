// class HealthTipsResponse {
//   bool isSuccess;
//   List<HtipsData> data;

//   HealthTipsResponse({this.isSuccess, this.data});

//   HealthTipsResponse.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = new List<HtipsData>();
//       json['data'].forEach((v) {
//         data.add(new HtipsData.fromJson(v));
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

// class HtipsData {
//   String tipsTitle;
//   String tipsUrl;

//   HtipsData({this.tipsTitle, this.tipsUrl});

//   HtipsData.fromJson(Map<String, dynamic> json) {
//     tipsTitle = json['tips_title'];
//     tipsUrl = json['tips_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tips_title'] = this.tipsTitle;
//     data['tips_url'] = this.tipsUrl;
//     return data;
//   }
// }
