// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

TransactionListModel transactionListModelFromJson(String str) => TransactionListModel.fromJson(json.decode(str));

String transactionListModelToJson(TransactionListModel data) => json.encode(data.toJson());

class TransactionListModel {
  String? message;
  List<TransactionModel>? response;
  bool? success;

  TransactionListModel({
    required this.message,
    required this.response,
    required this.success,
  });

  factory TransactionListModel.fromJson(Map<String, dynamic> json) => TransactionListModel(
    message: json["message"],
    response: json["response"] == null ? [] : List<TransactionModel>.from(json["response"].map((x) => TransactionModel.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "response": response,
    "success": success,
  };
}

class TransactionModel {
  String? beneficiaryFirstName;
  int? beneficiaryId;
  String? beneficiaryLastName;
  String? beneficiaryMiddleName;
  String? beneficiaryMobileNumber;
  bool? complianceChecked;
  bool? complianceNeeded;
  String? createdAt;
  String? destinationAmount;
  String? destinationCountry;
  String? destinationCurrency;
  bool? extComplianceChecked;
  bool? extComplianceNeeded;
  int? id;
  int? partnerId;
  String? paymentTypePi;
  int? remitterId;
  String? sourceAmount;
  String? sourceCountry;
  String? sourceCurrency;
  String? transSessionId;
  String? transactionStatus;
  String? transferTypePo;

  TransactionModel({
    required this.beneficiaryFirstName,
    required this.beneficiaryId,
    required this.beneficiaryLastName,
    required this.beneficiaryMiddleName,
    required this.beneficiaryMobileNumber,
    required this.complianceChecked,
    required this.complianceNeeded,
    required this.createdAt,
    required this.destinationAmount,
    required this.destinationCountry,
    required this.destinationCurrency,
    required this.extComplianceChecked,
    required this.extComplianceNeeded,
    required this.id,
    required this.partnerId,
    required this.paymentTypePi,
    required this.remitterId,
    required this.sourceAmount,
    required this.sourceCountry,
    required this.sourceCurrency,
    required this.transSessionId,
    required this.transactionStatus,
    required this.transferTypePo,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    beneficiaryFirstName: json["beneficiary_first_name"],
    beneficiaryId: json["beneficiary_id"],
    beneficiaryLastName: json["beneficiary_last_name"],
    beneficiaryMiddleName: json["beneficiary_middle_name"],
    beneficiaryMobileNumber: json["beneficiary_mobile_number"],
    complianceChecked: json["compliance_checked"],
    complianceNeeded: json["compliance_needed"],
    createdAt: json["created_at"],
    destinationAmount: json["destination_amount"],
    destinationCountry: json["destination_country"],
    destinationCurrency: json["destination_currency"],
    extComplianceChecked: json["ext_compliance_checked"],
    extComplianceNeeded: json["ext_compliance_needed"],
    id: json["id"],
    partnerId: json["partner_id"],
    paymentTypePi: json["payment_type_pi"],
    remitterId: json["remitter_id"],
    sourceAmount: json["source_amount"],
    sourceCountry: json["source_country"],
    sourceCurrency: json["source_currency"],
    transSessionId: json["trans_session_id"],
    transactionStatus: json["transaction_status"],
    transferTypePo: json["transfer_type_po"],
  );

  Map<String, dynamic> toJson() => {
    "beneficiary_first_name": beneficiaryFirstName,
    "beneficiary_id": beneficiaryId,
    "beneficiary_last_name": beneficiaryLastName,
    "beneficiary_middle_name": beneficiaryMiddleName,
    "beneficiary_mobile_number": beneficiaryMobileNumber,
    "compliance_checked": complianceChecked,
    "compliance_needed": complianceNeeded,
    "created_at": createdAt,
    "destination_amount": destinationAmount,
    "destination_country": destinationCountry,
    "destination_currency": destinationCurrency,
    "ext_compliance_checked": extComplianceChecked,
    "ext_compliance_needed": extComplianceNeeded,
    "id": id,
    "partner_id": partnerId,
    "payment_type_pi": paymentTypePi,
    "remitter_id": remitterId,
    "source_amount": sourceAmount,
    "source_country": sourceCountry,
    "source_currency": sourceCurrency,
    "trans_session_id": transSessionId,
    "transaction_status": transactionStatus,
    "transfer_type_po": transferTypePo,
  };

  String dateFormat(){
    final DateTime now = DateTime.parse(createdAt??'');
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
     return formatter.format(now);
  }
  String dateOnlyFormat(){
    final DateTime now = DateTime.parse(createdAt??'');
    final DateFormat formatter = DateFormat('d MMM');
     return formatter.format(now);
  }

}
