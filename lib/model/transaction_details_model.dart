// To parse this JSON data, do
//
//     final transactionDetailsModel = transactionDetailsModelFromJson(jsonString);

import 'dart:convert';

TransactionDetailsModel transactionDetailsModelFromJson(String str) => TransactionDetailsModel.fromJson(json.decode(str));

String transactionDetailsModelToJson(TransactionDetailsModel data) => json.encode(data.toJson());

class TransactionDetailsModel {
  String? message;
  bool? success;
  Response? response;

  TransactionDetailsModel({
     this.message,
     this.success,
     this.response,
  });

  factory TransactionDetailsModel.fromJson(Map<String, dynamic> json) => TransactionDetailsModel(
    message: json["Message"],
    success: json["Success"],
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Success": success,
    "response": response,
  };
}

class Response {
  int? accountItemNumber;
  int? agentCommision;
  int? agentFee;
  int? agentId;
  String? agentTransactionReferenceNumber;
  String? amountPaid;
  String? amountType;
  String? beneficiaryFirstName;
  int? beneficiaryId;
  String? beneficiaryLastName;
  String? beneficiaryMiddleName;
  String? beneficiaryMobileNumber;
  String? commentsOnBeneficiary;
  bool? complianceChecked;
  bool? complianceNeeded;
  String? createdAt;
  String? destinationAccount;
  String? destinationAmount;
  String? destinationCountry;
  String? destinationCurrency;
  bool? extComplianceChecked;
  bool? extComplianceNeeded;
  int? headOfficeFee;
  int? id;
  bool? isActive;
  bool? isOffline;
  int? partnerId;
  String? payInTransId;
  String? payOutTransId;
  String? payerName;
  String? paymentToken;
  String? paymentTypePi;
  int? payoutTransactionCount;
  String? promotionCode;
  String? purpose;
  String? reason;
  String? remitterFirstName;
  int? remitterId;
  String? remitterLastName;
  String? remitterMiddleName;
  String? remitterName;
  String? remitterWalletCurrency;
  int? serviceLevel;
  int? smsBeneConfirmationOtp;
  bool? smsBenefConfirmation;
  String? smsBenefMobile;
  bool? smsConfirmation;
  String? smsMobile;
  bool? smsNotification;
  int? smsRemitterConfirmationOtp;
  String? sourceAmount;
  String? sourceCountry;
  String? sourceCurrency;
  String? sourceOfIncome;
  int? tax;
  String? transSessionId;
  String? transactionStatus;
  String? transferTypePo;
  String? updatedAt;
  String? username;
  dynamic utilityBill;
  String? utilityBillDescription;
  String? utilityBillInvoice;
  int? zeepayId;

  Response({
     this.accountItemNumber,
     this.agentCommision,
     this.agentFee,
     this.agentId,
     this.agentTransactionReferenceNumber,
     this.amountPaid,
     this.amountType,
     this.beneficiaryFirstName,
     this.beneficiaryId,
     this.beneficiaryLastName,
     this.beneficiaryMiddleName,
     this.beneficiaryMobileNumber,
     this.commentsOnBeneficiary,
     this.complianceChecked,
     this.complianceNeeded,
     this.createdAt,
     this.destinationAccount,
     this.destinationAmount,
     this.destinationCountry,
     this.destinationCurrency,
     this.extComplianceChecked,
     this.extComplianceNeeded,
     this.headOfficeFee,
     this.id,
     this.isActive,
     this.isOffline,
     this.partnerId,
     this.payInTransId,
     this.payOutTransId,
     this.payerName,
     this.paymentToken,
     this.paymentTypePi,
     this.payoutTransactionCount,
     this.promotionCode,
     this.purpose,
     this.reason,
     this.remitterFirstName,
     this.remitterId,
     this.remitterLastName,
     this.remitterMiddleName,
     this.remitterName,
     this.remitterWalletCurrency,
     this.serviceLevel,
     this.smsBeneConfirmationOtp,
     this.smsBenefConfirmation,
     this.smsBenefMobile,
     this.smsConfirmation,
     this.smsMobile,
     this.smsNotification,
     this.smsRemitterConfirmationOtp,
     this.sourceAmount,
     this.sourceCountry,
     this.sourceCurrency,
     this.sourceOfIncome,
     this.tax,
     this.transSessionId,
     this.transactionStatus,
     this.transferTypePo,
     this.updatedAt,
     this.username,
     this.utilityBill,
     this.utilityBillDescription,
     this.utilityBillInvoice,
     this.zeepayId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    accountItemNumber: json["account_item_number"],
    agentCommision: json["agent_commision"],
    agentFee: json["agent_fee"],
    agentId: json["agent_id"],
    agentTransactionReferenceNumber: json["agent_transaction_reference_number"],
    amountPaid: json["amount_paid"],
    amountType: json["amount_type"],
    beneficiaryFirstName: json["beneficiary_first_name"],
    beneficiaryId: json["beneficiary_id"],
    beneficiaryLastName: json["beneficiary_last_name"],
    beneficiaryMiddleName: json["beneficiary_middle_name"],
    beneficiaryMobileNumber: json["beneficiary_mobile_number"],
    commentsOnBeneficiary: json["comments_on_beneficiary"],
    complianceChecked: json["compliance_checked"],
    complianceNeeded: json["compliance_needed"],
    createdAt: json["created_at"],
    destinationAccount: json["destination_account"],
    destinationAmount: json["destination_amount"],
    destinationCountry: json["destination_country"],
    destinationCurrency: json["destination_currency"],
    extComplianceChecked: json["ext_compliance_checked"],
    extComplianceNeeded: json["ext_compliance_needed"],
    headOfficeFee: json["head_office_fee"],
    id: json["id"],
    isActive: json["is_active"],
    isOffline: json["is_offline"],
    partnerId: json["partner_id"],
    payInTransId: json["pay_in_trans_id"],
    payOutTransId: json["pay_out_trans_id"],
    payerName: json["payer_name"],
    paymentToken: json["payment_token"],
    paymentTypePi: json["payment_type_pi"],
    payoutTransactionCount: json["payout_transaction_count"],
    promotionCode: json["promotion_code"],
    purpose: json["purpose"],
    reason: json["reason"],
    remitterFirstName: json["remitter_first_name"],
    remitterId: json["remitter_id"],
    remitterLastName: json["remitter_last_name"],
    remitterMiddleName: json["remitter_middle_name"],
    remitterName: json["remitter_name"],
    remitterWalletCurrency: json["remitter_wallet_currency"],
    serviceLevel: json["service_level"],
    smsBeneConfirmationOtp: json["sms_bene_confirmation_otp"],
    smsBenefConfirmation: json["sms_benef_confirmation"],
    smsBenefMobile: json["sms_benef_mobile"],
    smsConfirmation: json["sms_confirmation"],
    smsMobile: json["sms_mobile"],
    smsNotification: json["sms_notification"],
    smsRemitterConfirmationOtp: json["sms_remitter_confirmation_otp"],
    sourceAmount: json["source_amount"],
    sourceCountry: json["source_country"],
    sourceCurrency: json["source_currency"],
    sourceOfIncome: json["source_of_income"],
    tax: json["tax"],
    transSessionId: json["trans_session_id"],
    transactionStatus: json["transaction_status"],
    transferTypePo: json["transfer_type_po"],
    updatedAt: json["updated_at"],
    username: json["username"],
    utilityBill: json["utility_bill"],
    utilityBillDescription: json["utility_bill_description"],
    utilityBillInvoice: json["utility_bill_invoice"],
    zeepayId: json["zeepay_id"],
  );

  Map<String, dynamic> toJson() => {
    "account_item_number": accountItemNumber,
    "agent_commision": agentCommision,
    "agent_fee": agentFee,
    "agent_id": agentId,
    "agent_transaction_reference_number": agentTransactionReferenceNumber,
    "amount_paid": amountPaid,
    "amount_type": amountType,
    "beneficiary_first_name": beneficiaryFirstName,
    "beneficiary_id": beneficiaryId,
    "beneficiary_last_name": beneficiaryLastName,
    "beneficiary_middle_name": beneficiaryMiddleName,
    "beneficiary_mobile_number": beneficiaryMobileNumber,
    "comments_on_beneficiary": commentsOnBeneficiary,
    "compliance_checked": complianceChecked,
    "compliance_needed": complianceNeeded,
    "created_at": createdAt,
    "destination_account": destinationAccount,
    "destination_amount": destinationAmount,
    "destination_country": destinationCountry,
    "destination_currency": destinationCurrency,
    "ext_compliance_checked": extComplianceChecked,
    "ext_compliance_needed": extComplianceNeeded,
    "head_office_fee": headOfficeFee,
    "id": id,
    "is_active": isActive,
    "is_offline": isOffline,
    "partner_id": partnerId,
    "pay_in_trans_id": payInTransId,
    "pay_out_trans_id": payOutTransId,
    "payer_name": payerName,
    "payment_token": paymentToken,
    "payment_type_pi": paymentTypePi,
    "payout_transaction_count": payoutTransactionCount,
    "promotion_code": promotionCode,
    "purpose": purpose,
    "reason": reason,
    "remitter_first_name": remitterFirstName,
    "remitter_id": remitterId,
    "remitter_last_name": remitterLastName,
    "remitter_middle_name": remitterMiddleName,
    "remitter_name": remitterName,
    "remitter_wallet_currency": remitterWalletCurrency,
    "service_level": serviceLevel,
    "sms_bene_confirmation_otp": smsBeneConfirmationOtp,
    "sms_benef_confirmation": smsBenefConfirmation,
    "sms_benef_mobile": smsBenefMobile,
    "sms_confirmation": smsConfirmation,
    "sms_mobile": smsMobile,
    "sms_notification": smsNotification,
    "sms_remitter_confirmation_otp": smsRemitterConfirmationOtp,
    "source_amount": sourceAmount,
    "source_country": sourceCountry,
    "source_currency": sourceCurrency,
    "source_of_income": sourceOfIncome,
    "tax": tax,
    "trans_session_id": transSessionId,
    "transaction_status": transactionStatus,
    "transfer_type_po": transferTypePo,
    "updated_at": updatedAt,
    "username": username,
    "utility_bill": utilityBill,
    "utility_bill_description": utilityBillDescription,
    "utility_bill_invoice": utilityBillInvoice,
    "zeepay_id": zeepayId,
  };
}
