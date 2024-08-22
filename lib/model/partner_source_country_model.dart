// To parse this JSON data, do
//
//     final partnerCountryModel = partnerCountryModelFromJson(jsonString);

import 'dart:convert';

PartnerCountryModel partnerCountryModelFromJson(String str) => PartnerCountryModel.fromJson(json.decode(str));

String partnerCountryModelToJson(PartnerCountryModel data) => json.encode(data.toJson());

class PartnerCountryModel {
  bool success;
  String message;
  List<Response> response;

  PartnerCountryModel({
    required this.success,
    required this.message,
    required this.response,
  });

  factory PartnerCountryModel.fromJson(Map<String, dynamic> json) => PartnerCountryModel(
    success: json["success"],
    message: json["message"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  int partnerId;
  List<SourceCurrency> sourceCurrency;
  List<SourceCurrency> destinationCurrency;
  DateTime createdAt;
  DateTime updatedAt;

  Response({
    required this.partnerId,
    required this.sourceCurrency,
    required this.destinationCurrency,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    partnerId: json["partner_id"],
    sourceCurrency: json["source_currency"] == null ? [] : List<SourceCurrency>.from(json["source_currency"].map((x) => SourceCurrency.fromJson(x))),
    destinationCurrency: json["destination_currency"] == null ? [] : List<SourceCurrency>.from(json["destination_currency"].map((x) => SourceCurrency.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "partner_id": partnerId,
    "source_currency": sourceCurrency,
    "destination_currency": destinationCurrency,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class SourceCurrency {
  String mobileCode;
  String countryCode;
  String countryName;
  List<CurrencySupported> currencySupported;

  SourceCurrency({
    required this.mobileCode,
    required this.countryCode,
    required this.countryName,
    required this.currencySupported,
  });

  factory SourceCurrency.fromJson(Map<String, dynamic> json) => SourceCurrency(
    mobileCode: json["mobileCode"],
    countryCode: json["countryCode"],
    countryName: json["countryName"],
    currencySupported: List<CurrencySupported>.from(json["currencySupported"].map((x) => CurrencySupported.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mobileCode": mobileCode,
    "countryCode": countryCode,
    "countryName": countryName,
    "currencySupported": List<dynamic>.from(currencySupported.map((x) => x.toJson())),
  };
}

class CurrencySupported {
  String currency;

  CurrencySupported({
    required this.currency,
  });

  factory CurrencySupported.fromJson(Map<String, dynamic> json) => CurrencySupported(
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
  };
}
