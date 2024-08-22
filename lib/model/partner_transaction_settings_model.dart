class PartnerTransactionSettingsModel {
  bool? success;
  String? message;
  Response? response;
  Error? error;

  PartnerTransactionSettingsModel({this.success, this.message, this.response, this.error});

  PartnerTransactionSettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    error= json["error"] == null ? null : Error.fromJson(json["error"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.error != null)
    data["error"]= this.error;
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

class Response {
  int? id;
  int? partnerId;
  String? sourceCountry;
  String? destinationCountry;
  List<PaymentMethodCodes>? paymentMethodCodes;
  List<RemittancePurposeCodes>? remittancePurposeCodes;
  List<SourceOfIncomeCodes>? sourceOfIncomeCodes;
  List<ServiceLevelDeliverySpeedCodes>? serviceLevelDeliverySpeedCodes;
  List<TransferTypes>? transferTypes;
  List<String>? sourceCurrencies;
  List<String>? destinationCurrencies;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Response(
      {this.id,
      this.partnerId,
      this.sourceCountry,
      this.destinationCountry,
      this.paymentMethodCodes,
      this.remittancePurposeCodes,
      this.sourceOfIncomeCodes,
      this.serviceLevelDeliverySpeedCodes,
      this.transferTypes,
      this.sourceCurrencies,
      this.destinationCurrencies,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partnerId = json['partner_id'];
    sourceCountry = json['source_country'];
    destinationCountry = json['destination_country'];
    if (json['payment_method_codes'] != null) {
      paymentMethodCodes = <PaymentMethodCodes>[];
      json['payment_method_codes'].forEach((v) {
        paymentMethodCodes!.add(new PaymentMethodCodes.fromJson(v));
      });
    }
    if (json['remittance_purpose_codes'] != null) {
      remittancePurposeCodes = <RemittancePurposeCodes>[];
      json['remittance_purpose_codes'].forEach((v) {
        remittancePurposeCodes!.add(new RemittancePurposeCodes.fromJson(v));
      });
    }
    if (json['source_of_income_codes'] != null) {
      sourceOfIncomeCodes = <SourceOfIncomeCodes>[];
      json['source_of_income_codes'].forEach((v) {
        sourceOfIncomeCodes!.add(new SourceOfIncomeCodes.fromJson(v));
      });
    }
    if (json['service_level_delivery_speed_codes'] != null) {
      serviceLevelDeliverySpeedCodes = <ServiceLevelDeliverySpeedCodes>[];
      json['service_level_delivery_speed_codes'].forEach((v) {
        serviceLevelDeliverySpeedCodes!
            .add(new ServiceLevelDeliverySpeedCodes.fromJson(v));
      });
    }
    if (json['transfer_types'] != null) {
      transferTypes = <TransferTypes>[];
      json['transfer_types'].forEach((v) {
        transferTypes!.add(new TransferTypes.fromJson(v));
      });
    }
    sourceCurrencies = json['source_currencies'].cast<String>();
    destinationCurrencies = json['destination_currencies'].cast<String>();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partner_id'] = this.partnerId;
    data['source_country'] = this.sourceCountry;
    data['destination_country'] = this.destinationCountry;
    if (this.paymentMethodCodes != null) {
      data['payment_method_codes'] =
          this.paymentMethodCodes!.map((v) => v.toJson()).toList();
    }
    if (this.remittancePurposeCodes != null) {
      data['remittance_purpose_codes'] =
          this.remittancePurposeCodes!.map((v) => v.toJson()).toList();
    }
    if (this.sourceOfIncomeCodes != null) {
      data['source_of_income_codes'] =
          this.sourceOfIncomeCodes!.map((v) => v.toJson()).toList();
    }
    if (this.serviceLevelDeliverySpeedCodes != null) {
      data['service_level_delivery_speed_codes'] =
          this.serviceLevelDeliverySpeedCodes!.map((v) => v.toJson()).toList();
    }
    if (this.transferTypes != null) {
      data['transfer_types'] =
          this.transferTypes!.map((v) => v.toJson()).toList();
    }
    data['source_currencies'] = this.sourceCurrencies;
    data['destination_currencies'] = this.destinationCurrencies;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PaymentMethodCodes {
  int? code;
  String? name;
  String? imgPath;
  String? description;

  PaymentMethodCodes({this.code, this.name, this.imgPath, this.description});

  PaymentMethodCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    imgPath = json['imgPath'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['imgPath'] = this.imgPath;
    data['description'] = this.description;
    return data;
  }
}

class RemittancePurposeCodes {
  int? code;
  String? description;

  RemittancePurposeCodes({this.code, this.description});

  RemittancePurposeCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class TransferTypes {
  int? code;
  String? name;
  String? value;
  String? description;

  TransferTypes({this.code, this.name, this.value, this.description});

  TransferTypes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    value = json['value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['value'] = this.value;
    data['description'] = this.description;
    return data;
  }
}

class ServiceLevelDeliverySpeedCodes {
  int? code;
  String? description;

  ServiceLevelDeliverySpeedCodes({
    this.code,
    this.description,
  });

  ServiceLevelDeliverySpeedCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class SourceOfIncomeCodes {
  int? code;
  String? description;

  SourceOfIncomeCodes({
    this.code,
    this.description,
  });

  SourceOfIncomeCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}
