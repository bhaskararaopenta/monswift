/// message : "Data Fetched Successfully"
/// response : {"partner_id":19,"source_currency":{"mobileCode":"+44","countryCode":"GBR","countryName":"United Kingdom of Great Britain and Northern Ireland","countryAlpha2Code":"GB","currencySupported":[{"currency":"GBP"}]},"destination_currency":[{"mobileCode":"+61","countryCode":"AUS","countryName":"Australia","countryAlpha2Code":"AU","currencySupported":[{"currency":"AUD"}]},{"mobileCode":"+1","countryCode":"CAN","countryName":"Canada","countryAlpha2Code":"CA","currencySupported":[{"currency":"CAD"}]},{"mobileCode":"+253","countryCode":"DJI","countryName":"Djibouti","countryAlpha2Code":"DJ","currencySupported":[{"currency":"DJF"},{"currency":"USD"}]},{"mobileCode":"+20","countryCode":"EGY","countryName":"Egypt","countryAlpha2Code":"EG","currencySupported":[{"currency":"EGP"},{"currency":"USD"}]},{"mobileCode":"+251","countryCode":"ETH","countryName":"Ethiopia","countryAlpha2Code":"ET","currencySupported":[{"currency":"USD"},{"currency":"ETB"}]},{"mobileCode":"+254","countryCode":"KEN","countryName":"Kenya","countryAlpha2Code":"KE","currencySupported":[{"currency":"KES"},{"currency":"USD"}]},{"mobileCode":"+212","countryCode":"MAR","countryName":"Morocco","countryAlpha2Code":"MA","currencySupported":[{"currency":"MAD"},{"currency":"EUR"}]},{"mobileCode":"+974","countryCode":"QAT","countryName":"Qatar","countryAlpha2Code":"QA","currencySupported":[{"currency":"QAR"},{"currency":"USD"}]},{"mobileCode":"+252","countryCode":"SOM","countryName":"Somalia","countryAlpha2Code":"SO","currencySupported":[{"currency":"USD"}]},{"mobileCode":"+252","countryCode":"SOL","countryName":"Somaliland","countryAlpha2Code":"SQ","currencySupported":[{"currency":"USD"}]},{"mobileCode":"+27","countryCode":"ZAF","countryName":"South Africa","countryAlpha2Code":"ZA","currencySupported":[{"currency":"ZAR"},{"currency":"USD"}]},{"mobileCode":"+255","countryCode":"TZA","countryName":"Tanzania, United Republic of","countryAlpha2Code":"TZ","currencySupported":[{"currency":"TZS"},{"currency":"USD"}]},{"mobileCode":"+90","countryCode":"TUR","countryName":"Turkey","countryAlpha2Code":"TR","currencySupported":[{"currency":"TRY"},{"currency":"USD"}]},{"mobileCode":"+256","countryCode":"UGA","countryName":"Uganda","countryAlpha2Code":"UG","currencySupported":[{"currency":"UGX"},{"currency":"USD"}]},{"mobileCode":"+971","countryCode":"ARE","countryName":"United Arab Emirates","countryAlpha2Code":"AE","currencySupported":[{"currency":"AED"},{"currency":"USD"}]},{"mobileCode":"+44","countryCode":"GBR","countryName":"United Kingdom","countryAlpha2Code":"GB","currencySupported":[{"currency":"GBP"}]}],"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z"}
/// success : true

class PartnerDestinationCountryModel {
  PartnerDestinationCountryModel({
      this.message, 
      this.response, 
      this.success,});

  PartnerDestinationCountryModel.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
  }
  String? message;
  Response? response;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['success'] = success;
    return map;
  }

}

/// partner_id : 19
/// source_currency : {"mobileCode":"+44","countryCode":"GBR","countryName":"United Kingdom of Great Britain and Northern Ireland","countryAlpha2Code":"GB","currencySupported":[{"currency":"GBP"}]}
/// destination_currency : [{"mobileCode":"+61","countryCode":"AUS","countryName":"Australia","countryAlpha2Code":"AU","currencySupported":[{"currency":"AUD"}]},{"mobileCode":"+1","countryCode":"CAN","countryName":"Canada","countryAlpha2Code":"CA","currencySupported":[{"currency":"CAD"}]},{"mobileCode":"+253","countryCode":"DJI","countryName":"Djibouti","countryAlpha2Code":"DJ","currencySupported":[{"currency":"DJF"},{"currency":"USD"}]},{"mobileCode":"+20","countryCode":"EGY","countryName":"Egypt","countryAlpha2Code":"EG","currencySupported":[{"currency":"EGP"},{"currency":"USD"}]},{"mobileCode":"+251","countryCode":"ETH","countryName":"Ethiopia","countryAlpha2Code":"ET","currencySupported":[{"currency":"USD"},{"currency":"ETB"}]},{"mobileCode":"+254","countryCode":"KEN","countryName":"Kenya","countryAlpha2Code":"KE","currencySupported":[{"currency":"KES"},{"currency":"USD"}]},{"mobileCode":"+212","countryCode":"MAR","countryName":"Morocco","countryAlpha2Code":"MA","currencySupported":[{"currency":"MAD"},{"currency":"EUR"}]},{"mobileCode":"+974","countryCode":"QAT","countryName":"Qatar","countryAlpha2Code":"QA","currencySupported":[{"currency":"QAR"},{"currency":"USD"}]},{"mobileCode":"+252","countryCode":"SOM","countryName":"Somalia","countryAlpha2Code":"SO","currencySupported":[{"currency":"USD"}]},{"mobileCode":"+252","countryCode":"SOL","countryName":"Somaliland","countryAlpha2Code":"SQ","currencySupported":[{"currency":"USD"}]},{"mobileCode":"+27","countryCode":"ZAF","countryName":"South Africa","countryAlpha2Code":"ZA","currencySupported":[{"currency":"ZAR"},{"currency":"USD"}]},{"mobileCode":"+255","countryCode":"TZA","countryName":"Tanzania, United Republic of","countryAlpha2Code":"TZ","currencySupported":[{"currency":"TZS"},{"currency":"USD"}]},{"mobileCode":"+90","countryCode":"TUR","countryName":"Turkey","countryAlpha2Code":"TR","currencySupported":[{"currency":"TRY"},{"currency":"USD"}]},{"mobileCode":"+256","countryCode":"UGA","countryName":"Uganda","countryAlpha2Code":"UG","currencySupported":[{"currency":"UGX"},{"currency":"USD"}]},{"mobileCode":"+971","countryCode":"ARE","countryName":"United Arab Emirates","countryAlpha2Code":"AE","currencySupported":[{"currency":"AED"},{"currency":"USD"}]},{"mobileCode":"+44","countryCode":"GBR","countryName":"United Kingdom","countryAlpha2Code":"GB","currencySupported":[{"currency":"GBP"}]}]
/// created_at : "0001-01-01T00:00:00Z"
/// updated_at : "0001-01-01T00:00:00Z"

class Response {
  Response({
      this.partnerId, 
      this.sourceCurrency, 
      this.destinationCurrency, 
      this.createdAt, 
      this.updatedAt,});

  Response.fromJson(dynamic json) {
    partnerId = json['partner_id'];
    sourceCurrency = json['source_currency'] != null ? SourceCurrency.fromJson(json['source_currency']) : null;
    if (json['destination_currency'] != null) {
      destinationCurrency = [];
      json['destination_currency'].forEach((v) {
        destinationCurrency?.add(DestinationCurrency.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? partnerId;
  SourceCurrency? sourceCurrency;
  List<DestinationCurrency>? destinationCurrency;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partner_id'] = partnerId;
    if (sourceCurrency != null) {
      map['source_currency'] = sourceCurrency?.toJson();
    }
    if (destinationCurrency != null) {
      map['destination_currency'] = destinationCurrency?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// mobileCode : "+61"
/// countryCode : "AUS"
/// countryName : "Australia"
/// countryAlpha2Code : "AU"
/// currencySupported : [{"currency":"AUD"}]

class DestinationCurrency {
  DestinationCurrency({
      this.mobileCode, 
      this.countryCode, 
      this.countryName, 
      this.countryAlpha2Code, 
      this.currencySupported,});

  DestinationCurrency.fromJson(dynamic json) {
    mobileCode = json['mobileCode'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    countryAlpha2Code = json['countryAlpha2Code'];
    if (json['currencySupported'] != null) {
      currencySupported = [];
      json['currencySupported'].forEach((v) {
        currencySupported?.add(CurrencySupported.fromJson(v));
      });
    }
  }
  String? mobileCode;
  String? countryCode;
  String? countryName;
  String? countryAlpha2Code;
  List<CurrencySupported>? currencySupported;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileCode'] = mobileCode;
    map['countryCode'] = countryCode;
    map['countryName'] = countryName;
    map['countryAlpha2Code'] = countryAlpha2Code;
    if (currencySupported != null) {
      map['currencySupported'] = currencySupported?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// currency : "AUD"

class CurrencySupported {
  CurrencySupported({
      this.currency,});

  CurrencySupported.fromJson(dynamic json) {
    currency = json['currency'];
  }
  String? currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    return map;
  }

}

/// mobileCode : "+44"
/// countryCode : "GBR"
/// countryName : "United Kingdom of Great Britain and Northern Ireland"
/// countryAlpha2Code : "GB"
/// currencySupported : [{"currency":"GBP"}]

class SourceCurrency {
  SourceCurrency({
      this.mobileCode, 
      this.countryCode, 
      this.countryName, 
      this.countryAlpha2Code, 
      this.currencySupported,});

  SourceCurrency.fromJson(dynamic json) {
    mobileCode = json['mobileCode'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    countryAlpha2Code = json['countryAlpha2Code'];
    if (json['currencySupported'] != null) {
      currencySupported = [];
      json['currencySupported'].forEach((v) {
        currencySupported?.add(CurrencySupported.fromJson(v));
      });
    }
  }
  String? mobileCode;
  String? countryCode;
  String? countryName;
  String? countryAlpha2Code;
  List<CurrencySupported>? currencySupported;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileCode'] = mobileCode;
    map['countryCode'] = countryCode;
    map['countryName'] = countryName;
    map['countryAlpha2Code'] = countryAlpha2Code;
    if (currencySupported != null) {
      map['currencySupported'] = currencySupported?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// currency : "GBP"

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