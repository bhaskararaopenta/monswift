/// Message : "Schedule Transaction Created Successfully"
/// Success : true
/// response : {"id":4,"remitter_id":167,"partner_id":19,"beneficiary_id":374,"source_amount":12,"source_currency":"GBP","destination_amount":12,"destination_currency":"KES","rate":121.982,"total_fee":0.37,"scheduled_date":"12-02-2025","frequency":"Monthly","payment_type_pi":"debit-credit-card","transfer_type_po":"bank-transfer","source_of_income":"","execution_count":0,"transaction_record":null,"created_at":"2024-04-01T01:05:46.722381065Z","updated_at":"2024-04-01T01:05:46.722381065Z","is_active":true,"is_deleted":false}

class CreateScheduleTransaction {
  CreateScheduleTransaction({
      this.message, 
      this.success, 
      this.response,
    this.error});

  CreateScheduleTransaction.fromJson(dynamic json) {
    message = json['message'];
    success = json['success'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    error= json["error"] == null ? null : Error.fromJson(json["error"]);
  }
  String? message;
  bool? success;
  Response? response;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['success'] = success;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    if (error != null) map['error']= error;
    return map;
  }

}

/// id : 4
/// remitter_id : 167
/// partner_id : 19
/// beneficiary_id : 374
/// source_amount : 12
/// source_currency : "GBP"
/// destination_amount : 12
/// destination_currency : "KES"
/// rate : 121.982
/// total_fee : 0.37
/// scheduled_date : "12-02-2025"
/// frequency : "Monthly"
/// payment_type_pi : "debit-credit-card"
/// transfer_type_po : "bank-transfer"
/// source_of_income : ""
/// execution_count : 0
/// transaction_record : null
/// created_at : "2024-04-01T01:05:46.722381065Z"
/// updated_at : "2024-04-01T01:05:46.722381065Z"
/// is_active : true
/// is_deleted : false

class Response {
  Response({
      this.id, 
      this.remitterId, 
      this.partnerId, 
      this.beneficiaryId, 
      this.sourceAmount, 
      this.sourceCurrency, 
      this.destinationAmount, 
      this.destinationCurrency, 
      this.rate, 
      this.totalFee, 
      this.scheduledDate, 
      this.frequency, 
      this.paymentTypePi, 
      this.transferTypePo, 
      this.sourceOfIncome, 
      this.executionCount, 
      this.transactionRecord, 
      this.createdAt, 
      this.updatedAt, 
      this.isActive, 
      this.isDeleted,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    remitterId = json['remitter_id'];
    partnerId = json['partner_id'];
    beneficiaryId = json['beneficiary_id'];
    sourceAmount = json['source_amount'];
    sourceCurrency = json['source_currency'];
    destinationAmount = json['destination_amount'];
    destinationCurrency = json['destination_currency'];
    rate = json['rate'];
    totalFee = json['total_fee'];
    scheduledDate = json['scheduled_date'];
    frequency = json['frequency'];
    paymentTypePi = json['payment_type_pi'];
    transferTypePo = json['transfer_type_po'];
    sourceOfIncome = json['source_of_income'];
    executionCount = json['execution_count'];
    transactionRecord = json['transaction_record'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
  }
  int? id;
  int? remitterId;
  int? partnerId;
  int? beneficiaryId;
  double? sourceAmount;
  String? sourceCurrency;
  double? destinationAmount;
  String? destinationCurrency;
  double? rate;
  double? totalFee;
  String? scheduledDate;
  String? frequency;
  String? paymentTypePi;
  String? transferTypePo;
  String? sourceOfIncome;
  int? executionCount;
  dynamic transactionRecord;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  bool? isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['remitter_id'] = remitterId;
    map['partner_id'] = partnerId;
    map['beneficiary_id'] = beneficiaryId;
    map['source_amount'] = sourceAmount?.toDouble();
    map['source_currency'] = sourceCurrency;
    map['destination_amount'] = destinationAmount?.toDouble();
    map['destination_currency'] = destinationCurrency;
    map['rate'] = rate;
    map['total_fee'] = totalFee;
    map['scheduled_date'] = scheduledDate;
    map['frequency'] = frequency;
    map['payment_type_pi'] = paymentTypePi;
    map['transfer_type_po'] = transferTypePo;
    map['source_of_income'] = sourceOfIncome;
    map['execution_count'] = executionCount?.toDouble();
    map['transaction_record'] = transactionRecord;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
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