// To parse this JSON data, do
//
//     final profileDetailsModel = profileDetailsModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailsModel profileDetailsModelFromJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) => json.encode(data.toJson());

class ProfileDetailsModel {
  String message;
  List<Response> response;
  bool success;

  ProfileDetailsModel({
    required this.message,
    required this.response,
    required this.success,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
    message: json["message"],
    response: json["response"] == null ? [] : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "response": response,
    "success": success,
  };
}

class Response {
  String address1;
  String address2;
  String amlStatus;
  String city;
  String dateOfBirth;
  String documentExpiryDate;
  String documentNumber;
  String documentType;
  String email;
  String firstName;
  String gender;
  String kycStatus;
  String lastName;
  String middleName;
  String mobileNumber;
  String nationality;
  int partnerId;
  String postalCode;
  String referenceForVerification;
  String remitterEmailPartnerId;
  int remitterId;
  String remitterName;
  String sourceCountry;
  String status;

  Response({
    required this.address1,
    required this.address2,
    required this.amlStatus,
    required this.city,
    required this.dateOfBirth,
    required this.documentExpiryDate,
    required this.documentNumber,
    required this.documentType,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.kycStatus,
    required this.lastName,
    required this.middleName,
    required this.mobileNumber,
    required this.nationality,
    required this.partnerId,
    required this.postalCode,
    required this.referenceForVerification,
    required this.remitterEmailPartnerId,
    required this.remitterId,
    required this.remitterName,
    required this.sourceCountry,
    required this.status,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    address1: json["address1"],
    address2: json["address2"],
    amlStatus: json["aml_status"],
    city: json["city"],
    dateOfBirth: json["date_of_birth"],
    documentExpiryDate: json["document_expiry_date"],
    documentNumber: json["document_number"],
    documentType: json["document_type"],
    email: json["email"],
    firstName: json["first_name"],
    gender: json["gender"],
    kycStatus: json["kyc_status"],
    lastName: json["last_name"],
    middleName: json["middle_name"],
    mobileNumber: json["mobile_number"],
    nationality: json["nationality"],
    partnerId: json["partner_id"],
    postalCode: json["postal_code"],
    referenceForVerification: json["reference_for_verification"],
    remitterEmailPartnerId: json["remitter_email_partner_id"],
    remitterId: json["remitter_id"],
    remitterName: json["remitter_name"],
    sourceCountry: json["source_country"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "aml_status": amlStatus,
    "city": city,
    "date_of_birth": dateOfBirth,
    "document_expiry_date": documentExpiryDate,
    "document_number": documentNumber,
    "document_type": documentType,
    "email": email,
    "first_name": firstName,
    "gender": gender,
    "kyc_status": kycStatus,
    "last_name": lastName,
    "middle_name": middleName,
    "mobile_number": mobileNumber,
    "nationality": nationality,
    "partner_id": partnerId,
    "postal_code": postalCode,
    "reference_for_verification": referenceForVerification,
    "remitter_email_partner_id": remitterEmailPartnerId,
    "remitter_id": remitterId,
    "remitter_name": remitterName,
    "source_country": sourceCountry,
    "status": status,
  };
}
