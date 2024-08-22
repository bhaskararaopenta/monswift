/// message : "Logged in Successfully"
/// response : {"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyIjp7IklkIjoxNjcsIlBhcnRuZXJJZCI6MTksIlJvbGVUeXBlIjoiVVNFUiIsIlBhcnRuZXJLZXkiOiI4RkFGNTc2Ni1EMkY4LTRCNUEtOTE4NS04QzJGRjMwMUNCRUMiLCJFbWFpbCI6Imgub21hcjUwQGdtYWlsLmNvbSJ9LCJleHAiOjE3MTY5NTYxMzB9.8IiExl5vivvaYTkvieUZooJgHnKsQuHAFGgzK2Xft7A","userDetails":{"partner_id":19,"remitter_id":167,"remitter_name":"","first_name":"Hussein","last_name":"Omar","mobile_number":"+444123567894","email":"h.omar50@gmail.com","kyc_status":"KYC-NOTOK","aml_status":"AML-NOTOK","created_at":"2024-02-08T06:33:29.329087Z","pin":"0200","is_profile_updated":false}}
/// success : true

class RegisterModel {
  RegisterModel({
      this.message, 
      this.response, 
      this.success,this.error});

  RegisterModel.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }
  String? message;
  Response? response;
  bool? success;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['success'] = success;
    if (this.error != null) {
      map['error'] = this.error!.toJson();
    }
    return map;
  }

}

/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VyIjp7IklkIjoxNjcsIlBhcnRuZXJJZCI6MTksIlJvbGVUeXBlIjoiVVNFUiIsIlBhcnRuZXJLZXkiOiI4RkFGNTc2Ni1EMkY4LTRCNUEtOTE4NS04QzJGRjMwMUNCRUMiLCJFbWFpbCI6Imgub21hcjUwQGdtYWlsLmNvbSJ9LCJleHAiOjE3MTY5NTYxMzB9.8IiExl5vivvaYTkvieUZooJgHnKsQuHAFGgzK2Xft7A"
/// userDetails : {"partner_id":19,"remitter_id":167,"remitter_name":"","first_name":"Hussein","last_name":"Omar","mobile_number":"+444123567894","email":"h.omar50@gmail.com","kyc_status":"KYC-NOTOK","aml_status":"AML-NOTOK","created_at":"2024-02-08T06:33:29.329087Z","pin":"0200","is_profile_updated":false}

class Response {
  Response({
      this.token, 
      this.userDetails,});

  Response.fromJson(dynamic json) {
    token = json['token'];
    userDetails = json['userDetails'] != null ? UserDetails.fromJson(json['userDetails']) : null;
  }
  String? token;
  UserDetails? userDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (userDetails != null) {
      map['userDetails'] = userDetails?.toJson();
    }
    return map;
  }

}

/// partner_id : 19
/// remitter_id : 167
/// remitter_name : ""
/// first_name : "Hussein"
/// last_name : "Omar"
/// mobile_number : "+444123567894"
/// email : "h.omar50@gmail.com"
/// kyc_status : "KYC-NOTOK"
/// aml_status : "AML-NOTOK"
/// created_at : "2024-02-08T06:33:29.329087Z"
/// pin : "0200"
/// is_profile_updated : false

class UserDetails {
  UserDetails({
      this.partnerId, 
      this.remitterId, 
      this.remitterName, 
      this.firstName, 
      this.lastName, 
      this.mobileNumber, 
      this.email, 
      this.kycStatus, 
      this.amlStatus, 
      this.createdAt, 
      this.pin, 
      this.isProfileUpdated,});

  UserDetails.fromJson(dynamic json) {
    partnerId = json['partner_id'];
    remitterId = json['remitter_id'];
    remitterName = json['remitter_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    kycStatus = json['kyc_status'];
    amlStatus = json['aml_status'];
    createdAt = json['created_at'];
    pin = json['pin'];
    isProfileUpdated = json['is_profile_updated'];
  }
  int? partnerId;
  int? remitterId;
  String? remitterName;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? kycStatus;
  String? amlStatus;
  String? createdAt;
  String? pin;
  bool? isProfileUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partner_id'] = partnerId;
    map['remitter_id'] = remitterId;
    map['remitter_name'] = remitterName;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['mobile_number'] = mobileNumber;
    map['email'] = email;
    map['kyc_status'] = kycStatus;
    map['aml_status'] = amlStatus;
    map['created_at'] = createdAt;
    map['pin'] = pin;
    map['is_profile_updated'] = isProfileUpdated;
    return map;
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
