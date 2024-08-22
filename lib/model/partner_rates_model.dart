// To parse this JSON data, do
//
//     final partnerRatesModel = partnerRatesModelFromJson(jsonString);

import 'dart:convert';

PartnerRatesModel partnerRatesModelFromJson(String str) => PartnerRatesModel.fromJson(json.decode(str));

String partnerRatesModelToJson(PartnerRatesModel data) => json.encode(data.toJson());

class PartnerRatesModel {
  bool success;
  String? message;
  Response? response;
  Error? error;

  PartnerRatesModel({
    required this.success,
    required this.message,
    required this.response,
    this.error,
  });

  factory PartnerRatesModel.fromJson(Map<String, dynamic> json) => PartnerRatesModel(
    success: json["success"],
    message: json["message"],
    response: json["response"] == null ? null :Response.fromJson(json["response"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": response?.toJson(),
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


class Response {
  String amountToConvert;
  String conversionRate;
  String platformFee;
  String sourceAmount;
  String shouldArrive;
  String totalFees;

  Response({
    required this.amountToConvert,
    required this.conversionRate,
    required this.platformFee,
    required this.sourceAmount,
    required this.shouldArrive,
    required this.totalFees,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    amountToConvert: json["amount_to_convert"].toString(),
    conversionRate: json["master_rate"].toString(),
    platformFee: json["platform_fee"].toString(),
    sourceAmount: json["source_amount"].toString(),
   // receiveAmount: json["amount"].toString(),
    shouldArrive: json["should_arrive"],
    totalFees: json["total_Fees"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "amount_to_convert": amountToConvert,
    "master_rate": conversionRate,
    "platform_fee": platformFee,
    "source_amount": sourceAmount,
    "should_arrive": shouldArrive,
    "total_Fees": totalFees,
  };
}
