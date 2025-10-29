// class LoginResp {
//   String accessToken;
//   String tokenType;
//   String expiresAt;
//   String message;

//   LoginResp({this.accessToken, this.tokenType, this.expiresAt});

//   LoginResp.fromJson(Map<String, dynamic> json) {
//     accessToken = json['access_token'];
//     tokenType = json['token_type'];
//     expiresAt = json['expires_at'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['access_token'] = this.accessToken;
//     data['token_type'] = this.tokenType;
//     data['expires_at'] = this.expiresAt;
//     data['message'] = this.message;

//     return data;
//   }
// }
