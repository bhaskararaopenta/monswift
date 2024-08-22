// To parse this JSON data, do
//
//     final partnerDestinationModel = partnerDestinationModelFromJson(jsonString);

import 'dart:convert';

PartnerDestinationModel partnerDestinationModelFromJson(String str) => PartnerDestinationModel.fromJson(json.decode(str));

String partnerDestinationModelToJson(PartnerDestinationModel data) => json.encode(data.toJson());

class PartnerDestinationModel {
  bool success;
  String message;
  List<Response> response;

  PartnerDestinationModel({
    required this.success,
    required this.message,
    required this.response,
  });

  factory PartnerDestinationModel.fromJson(Map<String, dynamic> json) => PartnerDestinationModel(
    success: json["success"],
    message: json["message"],
    response: json["response"] == null ? [] : List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": response,
  };
}

class Response {
  String mobileCode;
  String countryCode;
  String countryName;
  List<String> currencySupported;

  Response({
    required this.mobileCode,
    required this.countryCode,
    required this.countryName,
    required this.currencySupported,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    mobileCode: json["mobileCode"],
    countryCode: json["countryCode"],
    countryName: json["countryName"],
    currencySupported:  json["currencySupported"] == null ? [] : List<String>.from(json["currencySupported"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mobileCode": mobileCode,
    "countryCode": countryCode,
    "countryName": countryName,
    "currencySupported": currencySupported,
  };
}
