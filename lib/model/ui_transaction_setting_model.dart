class UiTransactionSettingModel {
  Result? result;

  UiTransactionSettingModel({this.result});

  UiTransactionSettingModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  bool? showRateCalculator;
  bool? cashCollectionPin;
  bool? forceExistingUtilityCompany;
  RatesCalculatorAmounts? ratesCalculatorAmounts;
  List<String>? transferTypes;
  List<PaymentMethods>? paymentMethods;
  List<String>? sourceOfIncomes;
  String? defaultSourceOfIncome;
  List<String>? purposes;
  String? defaultPurpose;
  List<ServiceLevels>? serviceLevels;
  List<AccountTypes>? accountTypes;
  List<String>? sourceCurrencies;
  List<String>? destinationCurrencies;
  SmsOptions? smsOptions;
  String? bankBranchInputMethod;
  List<Elements>? elements;

  Result(
      {this.showRateCalculator,
        this.cashCollectionPin,
        this.forceExistingUtilityCompany,
        this.ratesCalculatorAmounts,
        this.transferTypes,
        this.paymentMethods,
        this.sourceOfIncomes,
        this.defaultSourceOfIncome,
        this.purposes,
        this.defaultPurpose,
        this.serviceLevels,
        this.accountTypes,
        this.sourceCurrencies,
        this.destinationCurrencies,
        this.smsOptions,
        this.bankBranchInputMethod,
        this.elements});

  Result.fromJson(Map<String, dynamic> json) {
    showRateCalculator = json['show_rate_calculator'];
    cashCollectionPin = json['cash_collection_pin'];
    forceExistingUtilityCompany = json['force_existing_utility_company'];
    ratesCalculatorAmounts = json['rates_calculator_amounts'] != null
        ? new RatesCalculatorAmounts.fromJson(json['rates_calculator_amounts'])
        : null;
    transferTypes = json['transfer_types'].cast<String>();
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    sourceOfIncomes = json['source_of_incomes'].cast<String>();
    defaultSourceOfIncome = json['default_source_of_income'];
    purposes = json['purposes'].cast<String>();
    defaultPurpose = json['default_purpose'];
    if (json['service_levels'] != null) {
      serviceLevels = <ServiceLevels>[];
      json['service_levels'].forEach((v) {
        serviceLevels!.add(new ServiceLevels.fromJson(v));
      });
    }
    if (json['account_types'] != null) {
      accountTypes = <AccountTypes>[];
      json['account_types'].forEach((v) {
        accountTypes!.add(new AccountTypes.fromJson(v));
      });
    }
    sourceCurrencies = json['source_currencies'].cast<String>();
    destinationCurrencies = json['destination_currencies'].cast<String>();
    smsOptions = json['sms_options'] != null
        ? new SmsOptions.fromJson(json['sms_options'])
        : null;
    bankBranchInputMethod = json['bank_branch_input_method'];
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_rate_calculator'] = this.showRateCalculator;
    data['cash_collection_pin'] = this.cashCollectionPin;
    data['force_existing_utility_company'] = this.forceExistingUtilityCompany;
    if (this.ratesCalculatorAmounts != null) {
      data['rates_calculator_amounts'] = this.ratesCalculatorAmounts!.toJson();
    }
    data['transfer_types'] = this.transferTypes;
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    data['source_of_incomes'] = this.sourceOfIncomes;
    data['default_source_of_income'] = this.defaultSourceOfIncome;
    data['purposes'] = this.purposes;
    data['default_purpose'] = this.defaultPurpose;
    if (this.serviceLevels != null) {
      data['service_levels'] =
          this.serviceLevels!.map((v) => v.toJson()).toList();
    }
    if (this.accountTypes != null) {
      data['account_types'] =
          this.accountTypes!.map((v) => v.toJson()).toList();
    }
    data['source_currencies'] = this.sourceCurrencies;
    data['destination_currencies'] = this.destinationCurrencies;
    if (this.smsOptions != null) {
      data['sms_options'] = this.smsOptions!.toJson();
    }
    data['bank_branch_input_method'] = this.bankBranchInputMethod;
    if (this.elements != null) {
      data['elements'] = this.elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatesCalculatorAmounts {
  bool? source;
  bool? destination;
  bool? totalToPay;

  RatesCalculatorAmounts({this.source, this.destination, this.totalToPay});

  RatesCalculatorAmounts.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    destination = json['destination'];
    totalToPay = json['total_to_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['total_to_pay'] = this.totalToPay;
    return data;
  }
}

class PaymentMethods {
  int? id;
  String? name;

  PaymentMethods({this.id, this.name});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ServiceLevels {
  int? id;
  String? name;
  String? displayName;
  int? ratePercentage;
  int? commissionPercentage;
  int? deliveryPeriod;
  String? transferType;
  String? defaultServiceLevel;

  ServiceLevels(
      {this.id,
        this.name,
        this.displayName,
        this.ratePercentage,
        this.commissionPercentage,
        this.deliveryPeriod,
        this.transferType,
        this.defaultServiceLevel});

  ServiceLevels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    ratePercentage = json['rate_percentage'];
    commissionPercentage = json['commission_percentage'];
    deliveryPeriod = json['delivery_period'];
    transferType = json['transfer_type'];
    defaultServiceLevel = json['default_service_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['rate_percentage'] = this.ratePercentage;
    data['commission_percentage'] = this.commissionPercentage;
    data['delivery_period'] = this.deliveryPeriod;
    data['transfer_type'] = this.transferType;
    data['default_service_level'] = this.defaultServiceLevel;
    return data;
  }
}

class AccountTypes {
  String? id;
  String? name;

  AccountTypes({this.id, this.name});

  AccountTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SmsOptions {
  String? smsConfirmationDisplay;
  String? smsNotificationDisplay;
  String? smsMobileDisplay;
  String? smsBenefConfirmationDisplay;
  String? smsBenefMobileDisplay;
  bool? smsMobileEditable;

  SmsOptions(
      {this.smsConfirmationDisplay,
        this.smsNotificationDisplay,
        this.smsMobileDisplay,
        this.smsBenefConfirmationDisplay,
        this.smsBenefMobileDisplay,
        this.smsMobileEditable});

  SmsOptions.fromJson(Map<String, dynamic> json) {
    smsConfirmationDisplay = json['sms_confirmation_display'];
    smsNotificationDisplay = json['sms_notification_display'];
    smsMobileDisplay = json['sms_mobile_display'];
    smsBenefConfirmationDisplay = json['sms_benef_confirmation_display'];
    smsBenefMobileDisplay = json['sms_benef_mobile_display'];
    smsMobileEditable = json['sms_mobile_editable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sms_confirmation_display'] = this.smsConfirmationDisplay;
    data['sms_notification_display'] = this.smsNotificationDisplay;
    data['sms_mobile_display'] = this.smsMobileDisplay;
    data['sms_benef_confirmation_display'] = this.smsBenefConfirmationDisplay;
    data['sms_benef_mobile_display'] = this.smsBenefMobileDisplay;
    data['sms_mobile_editable'] = this.smsMobileEditable;
    return data;
  }
}

class Elements {
  String? name;
  bool? required;
  bool? display;
  AdditionalAttributes? additionalAttributes;

  Elements({this.name, this.required, this.display, this.additionalAttributes});

  Elements.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    required = json['required'];
    display = json['display'];
    additionalAttributes = json['additional_attributes'] != null
        ? new AdditionalAttributes.fromJson(json['additional_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['required'] = this.required;
    data['display'] = this.display;
    if (this.additionalAttributes != null) {
      data['additional_attributes'] = this.additionalAttributes!.toJson();
    }
    return data;
  }
}

class AdditionalAttributes {
  int? minimumAge;
  int? maximumAge;

  AdditionalAttributes({this.minimumAge, this.maximumAge});

  AdditionalAttributes.fromJson(Map<String, dynamic> json) {
    minimumAge = json['minimum_age'];
    maximumAge = json['maximum_age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum_age'] = this.minimumAge;
    data['maximum_age'] = this.maximumAge;
    return data;
  }
}
