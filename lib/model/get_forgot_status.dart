class GetForgotStatus {
  Error? error;
  bool? isVerified;
  bool? success;
  String? token;

  GetForgotStatus({this.error, this.isVerified, this.success, this.token});

  GetForgotStatus.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    isVerified = json['is_verified'];
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['is_verified'] = this.isVerified;
    data['success'] = this.success;
    data['token']= token;
    return data;
  }
}

class Error {
  String? message;
  int? statusCode;

  Error({this.message, this.statusCode});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
