// To parse this JSON data, do
//
//     final payoutBankModel = payoutBankModelFromJson(jsonString);

import 'dart:convert';

PayoutBankModel payoutBankModelFromJson(String str) => PayoutBankModel.fromJson(json.decode(str));

String payoutBankModelToJson(PayoutBankModel data) => json.encode(data.toJson());

class PayoutBankModel {
  String message;
  bool success;
  List<PayoutBank>? response;
  Error? error;

  PayoutBankModel({
    required this.message,
    required this.success,
    required this.response,
    required this.error,
  });

  factory PayoutBankModel.fromJson(Map<String, dynamic> json) => PayoutBankModel(
    message: json["Message"],
    success: json["Success"],
    response: json["response"] == null ? [] : List<PayoutBank>.from(json["response"].map((x) => PayoutBank.fromJson(x))),
    error: json["error"] == null ? null :Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Success": success,
    "response": response,
    "error": error,
  };
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

class PayoutBank {
  String name;
  String code;
  String country;

  PayoutBank({
    required this.name,
    required this.code,
    required this.country,
  });

  factory PayoutBank.fromJson(Map<String, dynamic> json) => PayoutBank(
    name: json["name"],
    code: json["code"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "country": country,
  };
}
