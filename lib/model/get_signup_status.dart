class GetSignupStatus {
  Error? error;
  bool? isEmailVerified;
  bool? success;

  GetSignupStatus({this.error, this.isEmailVerified, this.success});

  GetSignupStatus.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    isEmailVerified = json['is_email_verified'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['is_email_verified'] = this.isEmailVerified;
    data['success'] = this.success;
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
