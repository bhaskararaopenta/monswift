/// success : true
/// message : "Success"
/// userPermissionDetails : {"permissions":null,"sections":null}
/// userDetails : {"partner_id":0,"remitter_id":0,"remitter_name":"","first_name":"","last_name":"","mobile_number":"","email":"","kyc_status":"","aml_status":"","created_at":"0001-01-01T00:00:00Z","is_profile_updated":false}

class SupportEmailModel {
  SupportEmailModel({
      this.success, 
      this.message, 
      this.userPermissionDetails, 
      this.userDetails,this.error});

  SupportEmailModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    userPermissionDetails = json['userPermissionDetails'] != null ? UserPermissionDetails.fromJson(json['userPermissionDetails']) : null;
    userDetails = json['userDetails'] != null ? UserDetails.fromJson(json['userDetails']) : null;
    error= json["error"] == null ? null : Error.fromJson(json["error"]);
  }
  bool? success;
  String? message;
  UserPermissionDetails? userPermissionDetails;
  UserDetails? userDetails;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (userPermissionDetails != null) {
      map['userPermissionDetails'] = userPermissionDetails?.toJson();
    }
    if (userDetails != null) {
      map['userDetails'] = userDetails?.toJson();
    }
    if (error != null) map['error']= error;
    return map;
  }

}

/// partner_id : 0
/// remitter_id : 0
/// remitter_name : ""
/// first_name : ""
/// last_name : ""
/// mobile_number : ""
/// email : ""
/// kyc_status : ""
/// aml_status : ""
/// created_at : "0001-01-01T00:00:00Z"
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
    map['is_profile_updated'] = isProfileUpdated;
    return map;
  }

}

/// permissions : null
/// sections : null

class UserPermissionDetails {
  UserPermissionDetails({
      this.permissions, 
      this.sections,});

  UserPermissionDetails.fromJson(dynamic json) {
    permissions = json['permissions'];
    sections = json['sections'];
  }
  dynamic permissions;
  dynamic sections;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['permissions'] = permissions;
    map['sections'] = sections;
    return map;
  }

}

class Error {
  String message;
  int statusCode;

  Error({
    required this.message,
    required this.statusCode,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    message: json["message"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
  };
}