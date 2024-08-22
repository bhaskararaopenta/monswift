class SetRemitterPin {
  bool? success;
  String? message;
  UserPermissionDetails? userPermissionDetails;
  UserDetails? userDetails;
  Error? error;

  SetRemitterPin(
      {this.success,
        this.message,
        this.userPermissionDetails,
        this.userDetails,
        this.error});

  SetRemitterPin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    userPermissionDetails = json['userPermissionDetails'] != null
        ? new UserPermissionDetails.fromJson(json['userPermissionDetails'])
        : null;
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    error= json["error"] == null ? null : Error.fromJson(json["error"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userPermissionDetails != null) {
      data['userPermissionDetails'] = this.userPermissionDetails!.toJson();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    data["error"]= error;
    return data;
  }
}

class UserPermissionDetails {
  Null? permissions;
  Null? sections;

  UserPermissionDetails({this.permissions, this.sections});

  UserPermissionDetails.fromJson(Map<String, dynamic> json) {
    permissions = json['permissions'];
    sections = json['sections'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permissions'] = this.permissions;
    data['sections'] = this.sections;
    return data;
  }
}

class UserDetails {
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

  UserDetails(
      {this.partnerId,
        this.remitterId,
        this.remitterName,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.email,
        this.kycStatus,
        this.amlStatus,
        this.createdAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partner_id'] = this.partnerId;
    data['remitter_id'] = this.remitterId;
    data['remitter_name'] = this.remitterName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['kyc_status'] = this.kycStatus;
    data['aml_status'] = this.amlStatus;
    data['created_at'] = this.createdAt;
    return data;
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