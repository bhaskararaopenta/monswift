/// message : "Data Fetched Successfully"
/// response : {"bene_id":954,"bene_first_name":"Jony","bene_middle_name":"","bene_last_name":"walker","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"465645600","bene_address":"as 12 s","bene_city":"Del","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","aml_status":"AML-SENT","is_active":true,"created_at":"2024-05-15T03:51:22.536747Z","updated_at":"2024-05-15T03:54:40.054218Z"}
/// success : true

class GetBeneficiaryByIdModel {
  GetBeneficiaryByIdModel({
    this.message,
    this.response,
    this.success,this.error});

  GetBeneficiaryByIdModel.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
    error=
    json["error"] == null ? null : Error.fromJson(json["error"]);
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
    if (error != null) map['error'] = error?.toJson();
    return map;
  }

}

/// bene_id : 954
/// bene_first_name : "Jony"
/// bene_middle_name : ""
/// bene_last_name : "walker"
/// bene_email : ""
/// gender : ""
/// bene_date_of_birth : ""
/// bene_mobile_code : "+252"
/// bene_mobile_number : "465645600"
/// bene_address : "as 12 s"
/// bene_city : "Del"
/// bene_post_code : ""
/// avatar : ""
/// remitter_beneficiary_relation : "Brother"
/// benificiary_country : "SOL"
/// transfer_type_po : ""
/// isactive : false
/// remitter_id : 276
/// partner_id : 19
/// purpose : ""
/// bene_card_number : ""
/// bene_bank_details : null
/// routing_number : ""
/// receiver_msisdn : ""
/// bene_billpay_accountno : ""
/// aml_status : "AML-SENT"
/// is_active : true
/// created_at : "2024-05-15T03:51:22.536747Z"
/// updated_at : "2024-05-15T03:54:40.054218Z"

class Response {
  Response({
    this.beneId,
    this.beneFirstName,
    this.beneMiddleName,
    this.beneLastName,
    this.beneEmail,
    this.gender,
    this.beneDateOfBirth,
    this.beneMobileCode,
    this.beneMobileNumber,
    this.beneAddress,
    this.beneCity,
    this.benePostCode,
    this.avatar,
    this.remitterBeneficiaryRelation,
    this.benificiaryCountry,
    this.transferTypePo,
    this.isactive,
    this.remitterId,
    this.partnerId,
    this.purpose,
    this.beneCardNumber,
    this.beneBankDetails,
    this.routingNumber,
    this.receiverMsisdn,
    this.beneBillpayAccountno,
    this.amlStatus,
    this.isActive,
    this.createdAt,
    this.updatedAt,});

  Response.fromJson(dynamic json) {
    beneId = json['bene_id'];
    beneFirstName = json['bene_first_name'];
    beneMiddleName = json['bene_middle_name'];
    beneLastName = json['bene_last_name'];
    beneEmail = json['bene_email'];
    gender = json['gender'];
    beneDateOfBirth = json['bene_date_of_birth'];
    beneMobileCode = json['bene_mobile_code'];
    beneMobileNumber = json['bene_mobile_number'];
    beneAddress = json['bene_address'];
    beneCity = json['bene_city'];
    benePostCode = json['bene_post_code'];
    avatar = json['avatar'];
    remitterBeneficiaryRelation = json['remitter_beneficiary_relation'];
    benificiaryCountry = json['benificiary_country'];
    transferTypePo = json['transfer_type_po'];
    isactive = json['isactive'];
    remitterId = json['remitter_id'];
    partnerId = json['partner_id'];
    purpose = json['purpose'];
    beneCardNumber = json['bene_card_number'];
    beneBankDetails = json['bene_bank_details'];
    routingNumber = json['routing_number'];
    receiverMsisdn = json['receiver_msisdn'];
    beneBillpayAccountno = json['bene_billpay_accountno'];
    amlStatus = json['aml_status'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? beneId;
  String? beneFirstName;
  String? beneMiddleName;
  String? beneLastName;
  String? beneEmail;
  String? gender;
  String? beneDateOfBirth;
  String? beneMobileCode;
  String? beneMobileNumber;
  String? beneAddress;
  String? beneCity;
  String? benePostCode;
  String? avatar;
  String? remitterBeneficiaryRelation;
  String? benificiaryCountry;
  String? transferTypePo;
  bool? isactive;
  int? remitterId;
  int? partnerId;
  String? purpose;
  String? beneCardNumber;
  dynamic beneBankDetails;
  String? routingNumber;
  String? receiverMsisdn;
  String? beneBillpayAccountno;
  String? amlStatus;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bene_id'] = beneId;
    map['bene_first_name'] = beneFirstName;
    map['bene_middle_name'] = beneMiddleName;
    map['bene_last_name'] = beneLastName;
    map['bene_email'] = beneEmail;
    map['gender'] = gender;
    map['bene_date_of_birth'] = beneDateOfBirth;
    map['bene_mobile_code'] = beneMobileCode;
    map['bene_mobile_number'] = beneMobileNumber;
    map['bene_address'] = beneAddress;
    map['bene_city'] = beneCity;
    map['bene_post_code'] = benePostCode;
    map['avatar'] = avatar;
    map['remitter_beneficiary_relation'] = remitterBeneficiaryRelation;
    map['benificiary_country'] = benificiaryCountry;
    map['transfer_type_po'] = transferTypePo;
    map['isactive'] = isactive;
    map['remitter_id'] = remitterId;
    map['partner_id'] = partnerId;
    map['purpose'] = purpose;
    map['bene_card_number'] = beneCardNumber;
    map['bene_bank_details'] = beneBankDetails;
    map['routing_number'] = routingNumber;
    map['receiver_msisdn'] = receiverMsisdn;
    map['bene_billpay_accountno'] = beneBillpayAccountno;
    map['aml_status'] = amlStatus;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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