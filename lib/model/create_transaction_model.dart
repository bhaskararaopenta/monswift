/// message : "Transaction Created"
/// response : {"data":{"beneficiaryData":{"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:03:21.261984847Z"},"billpaymentData":{"id":0,"remitter_id":0,"payer_name":"","destination_account":"","source_country":"","source_currency":"","destination_country":"","destination_currency":"","send_amount":0,"receive_amount":0,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z"},"transactionData":{"id":1479,"username":"","remitter_id":276,"partner_id":19,"payment_type_pi":"debit-credit-card","beneficiary_id":947,"source_country":"GBR","destination_country":"SOL","source_currency":"GBP","destination_currency":"USD","destination_account":"","payer_name":"","amount_type":"SOURCE","source_amount":"100.00","destination_amount":"119.66","pay_in_trans_id":"","pay_out_trans_id":"","purpose":"Education Support","source_of_income":"Salary","account_item_number":0,"transfer_type_po":"cash-pickup","utility_bill":null,"tax":0,"rate":1.20104669,"total_fee":0.37,"head_office_fee":0,"amount_paid":"","reason":"","agent_id":0,"agent_commision":0,"agent_fee":0,"agent_transaction_reference_number":"","compliance_needed":false,"compliance_checked":false,"ext_compliance_needed":false,"ext_compliance_checked":false,"payment_token":"","remitter_wallet_currency":"","service_level":1,"promotion_code":"","sms_confirmation":false,"sms_notification":false,"sms_mobile":"","sms_benef_confirmation":false,"sms_benef_mobile":"","utility_bill_invoice":"","utility_bill_description":"","comments_on_beneficiary":"","trans_session_id":"48004025","transaction_status":"Created","payout_transaction_count":0,"sms_bene_confirmation_otp":0,"sms_remitter_confirmation_otp":0,"zeepay_id":0,"channel":"mobile","is_scheduled_transaction":false,"is_offline":false,"is_active":true,"created_at":"2024-05-15T04:03:20.243987482Z","processed_at":"0001-01-01T00:00:00Z","bene_data":{"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:02:55.586495Z"},"updated_at":"2024-05-15T04:03:20.243987482Z"},"trustPaymentData":{"allurlnotification":"Not Available in PartnerSettings","clientName":"jwt@nationremit.com","currentTimeStamp":"2024-05-15 04:03:25","declinedurlnotification":"Not Available in PartnerSettings","hash":"h31d504aadd98883f475c393f281984931167d861f9d6b421dd9a2e1384653f3c","m_declinedurlredirect":"Not Available in PartnerSettings","m_errorurlredirect":"Not Available in PartnerSettings","m_successfulurlredirect":"Not Available in PartnerSettings","m_webviewurl":"Not Available in PartnerSettings","siteReference":"test_nationremitltd86920","successfulurlnotification":"Not Available in PartnerSettings"}}}
/// success : true

class CreateTransactionModel {
  CreateTransactionModel({
    this.message,
    this.response,
    this.success, this.error});

  CreateTransactionModel.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
    error= json["error"] == null ? null : Error.fromJson(json["error"]);
  }
  String? message;
  Response? response;
  bool? success;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['success'] = success;
    if (error != null) map['error']= error;
    return map;
  }

}

/// data : {"beneficiaryData":{"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:03:21.261984847Z"},"billpaymentData":{"id":0,"remitter_id":0,"payer_name":"","destination_account":"","source_country":"","source_currency":"","destination_country":"","destination_currency":"","send_amount":0,"receive_amount":0,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z"},"transactionData":{"id":1479,"username":"","remitter_id":276,"partner_id":19,"payment_type_pi":"debit-credit-card","beneficiary_id":947,"source_country":"GBR","destination_country":"SOL","source_currency":"GBP","destination_currency":"USD","destination_account":"","payer_name":"","amount_type":"SOURCE","source_amount":"100.00","destination_amount":"119.66","pay_in_trans_id":"","pay_out_trans_id":"","purpose":"Education Support","source_of_income":"Salary","account_item_number":0,"transfer_type_po":"cash-pickup","utility_bill":null,"tax":0,"rate":1.20104669,"total_fee":0.37,"head_office_fee":0,"amount_paid":"","reason":"","agent_id":0,"agent_commision":0,"agent_fee":0,"agent_transaction_reference_number":"","compliance_needed":false,"compliance_checked":false,"ext_compliance_needed":false,"ext_compliance_checked":false,"payment_token":"","remitter_wallet_currency":"","service_level":1,"promotion_code":"","sms_confirmation":false,"sms_notification":false,"sms_mobile":"","sms_benef_confirmation":false,"sms_benef_mobile":"","utility_bill_invoice":"","utility_bill_description":"","comments_on_beneficiary":"","trans_session_id":"48004025","transaction_status":"Created","payout_transaction_count":0,"sms_bene_confirmation_otp":0,"sms_remitter_confirmation_otp":0,"zeepay_id":0,"channel":"mobile","is_scheduled_transaction":false,"is_offline":false,"is_active":true,"created_at":"2024-05-15T04:03:20.243987482Z","processed_at":"0001-01-01T00:00:00Z","bene_data":{"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:02:55.586495Z"},"updated_at":"2024-05-15T04:03:20.243987482Z"},"trustPaymentData":{"allurlnotification":"Not Available in PartnerSettings","clientName":"jwt@nationremit.com","currentTimeStamp":"2024-05-15 04:03:25","declinedurlnotification":"Not Available in PartnerSettings","hash":"h31d504aadd98883f475c393f281984931167d861f9d6b421dd9a2e1384653f3c","m_declinedurlredirect":"Not Available in PartnerSettings","m_errorurlredirect":"Not Available in PartnerSettings","m_successfulurlredirect":"Not Available in PartnerSettings","m_webviewurl":"Not Available in PartnerSettings","siteReference":"test_nationremitltd86920","successfulurlnotification":"Not Available in PartnerSettings"}}

class Response {
  Response({
    this.data,});

  Response.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// beneficiaryData : {"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:03:21.261984847Z"}
/// billpaymentData : {"id":0,"remitter_id":0,"payer_name":"","destination_account":"","source_country":"","source_currency":"","destination_country":"","destination_currency":"","send_amount":0,"receive_amount":0,"created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z"}
/// transactionData : {"id":1479,"username":"","remitter_id":276,"partner_id":19,"payment_type_pi":"debit-credit-card","beneficiary_id":947,"source_country":"GBR","destination_country":"SOL","source_currency":"GBP","destination_currency":"USD","destination_account":"","payer_name":"","amount_type":"SOURCE","source_amount":"100.00","destination_amount":"119.66","pay_in_trans_id":"","pay_out_trans_id":"","purpose":"Education Support","source_of_income":"Salary","account_item_number":0,"transfer_type_po":"cash-pickup","utility_bill":null,"tax":0,"rate":1.20104669,"total_fee":0.37,"head_office_fee":0,"amount_paid":"","reason":"","agent_id":0,"agent_commision":0,"agent_fee":0,"agent_transaction_reference_number":"","compliance_needed":false,"compliance_checked":false,"ext_compliance_needed":false,"ext_compliance_checked":false,"payment_token":"","remitter_wallet_currency":"","service_level":1,"promotion_code":"","sms_confirmation":false,"sms_notification":false,"sms_mobile":"","sms_benef_confirmation":false,"sms_benef_mobile":"","utility_bill_invoice":"","utility_bill_description":"","comments_on_beneficiary":"","trans_session_id":"48004025","transaction_status":"Created","payout_transaction_count":0,"sms_bene_confirmation_otp":0,"sms_remitter_confirmation_otp":0,"zeepay_id":0,"channel":"mobile","is_scheduled_transaction":false,"is_offline":false,"is_active":true,"created_at":"2024-05-15T04:03:20.243987482Z","processed_at":"0001-01-01T00:00:00Z","bene_data":{"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:02:55.586495Z"},"updated_at":"2024-05-15T04:03:20.243987482Z"}
/// trustPaymentData : {"allurlnotification":"Not Available in PartnerSettings","clientName":"jwt@nationremit.com","currentTimeStamp":"2024-05-15 04:03:25","declinedurlnotification":"Not Available in PartnerSettings","hash":"h31d504aadd98883f475c393f281984931167d861f9d6b421dd9a2e1384653f3c","m_declinedurlredirect":"Not Available in PartnerSettings","m_errorurlredirect":"Not Available in PartnerSettings","m_successfulurlredirect":"Not Available in PartnerSettings","m_webviewurl":"Not Available in PartnerSettings","siteReference":"test_nationremitltd86920","successfulurlnotification":"Not Available in PartnerSettings"}

class Data {
  Data({
    this.beneficiaryData,
    this.billpaymentData,
    this.transactionData,
    this.trustPaymentData,});

  Data.fromJson(dynamic json) {
    beneficiaryData = json['beneficiaryData'] != null ? BeneficiaryData.fromJson(json['beneficiaryData']) : null;
    billpaymentData = json['billpaymentData'] != null ? BillpaymentData.fromJson(json['billpaymentData']) : null;
    transactionData = json['transactionData'] != null ? TransactionData.fromJson(json['transactionData']) : null;
    trustPaymentData = json['trustPaymentData'] != null ? TrustPaymentData.fromJson(json['trustPaymentData']) : null;
  }
  BeneficiaryData? beneficiaryData;
  BillpaymentData? billpaymentData;
  TransactionData? transactionData;
  TrustPaymentData? trustPaymentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (beneficiaryData != null) {
      map['beneficiaryData'] = beneficiaryData?.toJson();
    }
    if (billpaymentData != null) {
      map['billpaymentData'] = billpaymentData?.toJson();
    }
    if (transactionData != null) {
      map['transactionData'] = transactionData?.toJson();
    }
    if (trustPaymentData != null) {
      map['trustPaymentData'] = trustPaymentData?.toJson();
    }
    return map;
  }

}

/// allurlnotification : "Not Available in PartnerSettings"
/// clientName : "jwt@nationremit.com"
/// currentTimeStamp : "2024-05-15 04:03:25"
/// declinedurlnotification : "Not Available in PartnerSettings"
/// hash : "h31d504aadd98883f475c393f281984931167d861f9d6b421dd9a2e1384653f3c"
/// m_declinedurlredirect : "Not Available in PartnerSettings"
/// m_errorurlredirect : "Not Available in PartnerSettings"
/// m_successfulurlredirect : "Not Available in PartnerSettings"
/// m_webviewurl : "Not Available in PartnerSettings"
/// siteReference : "test_nationremitltd86920"
/// successfulurlnotification : "Not Available in PartnerSettings"

class TrustPaymentData {
  TrustPaymentData({
    this.allurlnotification,
    this.clientName,
    this.currentTimeStamp,
    this.declinedurlnotification,
    this.hash,
    this.mDeclinedurlredirect,
    this.mErrorurlredirect,
    this.mSuccessfulurlredirect,
    this.mWebviewurl,
    this.siteReference,
    this.successfulurlnotification,});

  TrustPaymentData.fromJson(dynamic json) {
    allurlnotification = json['allurlnotification'];
    clientName = json['clientName'];
    currentTimeStamp = json['currentTimeStamp'];
    declinedurlnotification = json['declinedurlnotification'];
    hash = json['hash'];
    mDeclinedurlredirect = json['m_declinedurlredirect'];
    mErrorurlredirect = json['m_errorurlredirect'];
    mSuccessfulurlredirect = json['m_successfulurlredirect'];
    mWebviewurl = json['m_webviewurl'];
    siteReference = json['siteReference'];
    successfulurlnotification = json['successfulurlnotification'];
  }
  String? allurlnotification;
  String? clientName;
  String? currentTimeStamp;
  String? declinedurlnotification;
  String? hash;
  String? mDeclinedurlredirect;
  String? mErrorurlredirect;
  String? mSuccessfulurlredirect;
  String? mWebviewurl;
  String? siteReference;
  String? successfulurlnotification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allurlnotification'] = allurlnotification;
    map['clientName'] = clientName;
    map['currentTimeStamp'] = currentTimeStamp;
    map['declinedurlnotification'] = declinedurlnotification;
    map['hash'] = hash;
    map['m_declinedurlredirect'] = mDeclinedurlredirect;
    map['m_errorurlredirect'] = mErrorurlredirect;
    map['m_successfulurlredirect'] = mSuccessfulurlredirect;
    map['m_webviewurl'] = mWebviewurl;
    map['siteReference'] = siteReference;
    map['successfulurlnotification'] = successfulurlnotification;
    return map;
  }

}

/// id : 1479
/// username : ""
/// remitter_id : 276
/// partner_id : 19
/// payment_type_pi : "debit-credit-card"
/// beneficiary_id : 947
/// source_country : "GBR"
/// destination_country : "SOL"
/// source_currency : "GBP"
/// destination_currency : "USD"
/// destination_account : ""
/// payer_name : ""
/// amount_type : "SOURCE"
/// source_amount : "100.00"
/// destination_amount : "119.66"
/// pay_in_trans_id : ""
/// pay_out_trans_id : ""
/// purpose : "Education Support"
/// source_of_income : "Salary"
/// account_item_number : 0
/// transfer_type_po : "cash-pickup"
/// utility_bill : null
/// tax : 0
/// rate : 1.20104669
/// total_fee : 0.37
/// head_office_fee : 0
/// amount_paid : ""
/// reason : ""
/// agent_id : 0
/// agent_commision : 0
/// agent_fee : 0
/// agent_transaction_reference_number : ""
/// compliance_needed : false
/// compliance_checked : false
/// ext_compliance_needed : false
/// ext_compliance_checked : false
/// payment_token : ""
/// remitter_wallet_currency : ""
/// service_level : 1
/// promotion_code : ""
/// sms_confirmation : false
/// sms_notification : false
/// sms_mobile : ""
/// sms_benef_confirmation : false
/// sms_benef_mobile : ""
/// utility_bill_invoice : ""
/// utility_bill_description : ""
/// comments_on_beneficiary : ""
/// trans_session_id : "48004025"
/// transaction_status : "Created"
/// payout_transaction_count : 0
/// sms_bene_confirmation_otp : 0
/// sms_remitter_confirmation_otp : 0
/// zeepay_id : 0
/// channel : "mobile"
/// is_scheduled_transaction : false
/// is_offline : false
/// is_active : true
/// created_at : "2024-05-15T04:03:20.243987482Z"
/// processed_at : "0001-01-01T00:00:00Z"
/// bene_data : {"bene_id":947,"bene_first_name":"BeneTest","bene_middle_name":"","bene_last_name":"Create","bene_email":"","gender":"","bene_date_of_birth":"","bene_mobile_code":"+252","bene_mobile_number":"123457678","bene_address":"address ","bene_city":"london","bene_post_code":"","avatar":"","remitter_beneficiary_relation":"Brother","benificiary_country":"SOL","transfer_type_po":"","isactive":false,"remitter_id":276,"partner_id":19,"purpose":"","bene_card_number":"","bene_bank_details":null,"routing_number":"","receiver_msisdn":"","bene_billpay_accountno":"","collection_point_id":34,"collection_point_name":"XASAN KURUSOW /MOHAMUD OSMAN","collection_point_code":"BAKAALSO","collection_point_proc_bank":"Bank Bakaal Somalia","collection_point_address":"AFGOOYE","collection_point_city":"AFGOOYE","collection_point_state":"AFGOOYE","mobile_transfer_number":"888555555","mobile_transfer_network":"E Dahab","mobile_transfer_network_id":33,"aml_status":"AML-SENT","is_favorite":true,"is_active":true,"created_at":"2024-05-09T11:23:36.399967Z","updated_at":"2024-05-15T04:02:55.586495Z"}
/// updated_at : "2024-05-15T04:03:20.243987482Z"

class TransactionData {
  TransactionData({
    this.id,
    this.username,
    this.remitterId,
    this.partnerId,
    this.paymentTypePi,
    this.beneficiaryId,
    this.sourceCountry,
    this.destinationCountry,
    this.sourceCurrency,
    this.destinationCurrency,
    this.destinationAccount,
    this.payerName,
    this.amountType,
    this.sourceAmount,
    this.destinationAmount,
    this.payInTransId,
    this.payOutTransId,
    this.purpose,
    this.sourceOfIncome,
    this.accountItemNumber,
    this.transferTypePo,
    this.utilityBill,
    this.tax,
    this.rate,
    this.totalFee,
    this.headOfficeFee,
    this.amountPaid,
    this.reason,
    this.agentId,
    this.agentCommision,
    this.agentFee,
    this.agentTransactionReferenceNumber,
    this.complianceNeeded,
    this.complianceChecked,
    this.extComplianceNeeded,
    this.extComplianceChecked,
    this.paymentToken,
    this.remitterWalletCurrency,
    this.serviceLevel,
    this.promotionCode,
    this.smsConfirmation,
    this.smsNotification,
    this.smsMobile,
    this.smsBenefConfirmation,
    this.smsBenefMobile,
    this.utilityBillInvoice,
    this.utilityBillDescription,
    this.commentsOnBeneficiary,
    this.transSessionId,
    this.transactionStatus,
    this.payoutTransactionCount,
    this.smsBeneConfirmationOtp,
    this.smsRemitterConfirmationOtp,
    this.zeepayId,
    this.channel,
    this.isScheduledTransaction,
    this.isOffline,
    this.isActive,
    this.createdAt,
    this.processedAt,
    this.beneData,
    this.updatedAt,});

  TransactionData.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    remitterId = json['remitter_id'];
    partnerId = json['partner_id'];
    paymentTypePi = json['payment_type_pi'];
    beneficiaryId = json['beneficiary_id'];
    sourceCountry = json['source_country'];
    destinationCountry = json['destination_country'];
    sourceCurrency = json['source_currency'];
    destinationCurrency = json['destination_currency'];
    destinationAccount = json['destination_account'];
    payerName = json['payer_name'];
    amountType = json['amount_type'];
    sourceAmount = json['source_amount'];
    destinationAmount = json['destination_amount'];
    payInTransId = json['pay_in_trans_id'];
    payOutTransId = json['pay_out_trans_id'];
    purpose = json['purpose'];
    sourceOfIncome = json['source_of_income'];
    accountItemNumber = json['account_item_number'];
    transferTypePo = json['transfer_type_po'];
    utilityBill = json['utility_bill'];
    tax = json['tax'];
    rate = json['rate'];
    totalFee = json['total_fee'];
    headOfficeFee = json['head_office_fee'];
    amountPaid = json['amount_paid'];
    reason = json['reason'];
    agentId = json['agent_id'];
    agentCommision = json['agent_commision'];
    agentFee = json['agent_fee'];
    agentTransactionReferenceNumber = json['agent_transaction_reference_number'];
    complianceNeeded = json['compliance_needed'];
    complianceChecked = json['compliance_checked'];
    extComplianceNeeded = json['ext_compliance_needed'];
    extComplianceChecked = json['ext_compliance_checked'];
    paymentToken = json['payment_token'];
    remitterWalletCurrency = json['remitter_wallet_currency'];
    serviceLevel = json['service_level'];
    promotionCode = json['promotion_code'];
    smsConfirmation = json['sms_confirmation'];
    smsNotification = json['sms_notification'];
    smsMobile = json['sms_mobile'];
    smsBenefConfirmation = json['sms_benef_confirmation'];
    smsBenefMobile = json['sms_benef_mobile'];
    utilityBillInvoice = json['utility_bill_invoice'];
    utilityBillDescription = json['utility_bill_description'];
    commentsOnBeneficiary = json['comments_on_beneficiary'];
    transSessionId = json['trans_session_id'];
    transactionStatus = json['transaction_status'];
    payoutTransactionCount = json['payout_transaction_count'];
    smsBeneConfirmationOtp = json['sms_bene_confirmation_otp'];
    smsRemitterConfirmationOtp = json['sms_remitter_confirmation_otp'];
    zeepayId = json['zeepay_id'];
    channel = json['channel'];
    isScheduledTransaction = json['is_scheduled_transaction'];
    isOffline = json['is_offline'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    processedAt = json['processed_at'];
    beneData = json['bene_data'] != null ? BeneData.fromJson(json['bene_data']) : null;
    updatedAt = json['updated_at'];
  }
  int? id;
  String? username;
  int? remitterId;
  int? partnerId;
  String? paymentTypePi;
  int? beneficiaryId;
  String? sourceCountry;
  String? destinationCountry;
  String? sourceCurrency;
  String? destinationCurrency;
  String? destinationAccount;
  String? payerName;
  String? amountType;
  String? sourceAmount;
  String? destinationAmount;
  String? payInTransId;
  String? payOutTransId;
  String? purpose;
  String? sourceOfIncome;
  int? accountItemNumber;
  String? transferTypePo;
  dynamic utilityBill;
  int? tax;
  double? rate;
  double? totalFee;
  int? headOfficeFee;
  String? amountPaid;
  String? reason;
  int? agentId;
  int? agentCommision;
  int? agentFee;
  String? agentTransactionReferenceNumber;
  bool? complianceNeeded;
  bool? complianceChecked;
  bool? extComplianceNeeded;
  bool? extComplianceChecked;
  String? paymentToken;
  String? remitterWalletCurrency;
  int? serviceLevel;
  String? promotionCode;
  bool? smsConfirmation;
  bool? smsNotification;
  String? smsMobile;
  bool? smsBenefConfirmation;
  String? smsBenefMobile;
  String? utilityBillInvoice;
  String? utilityBillDescription;
  String? commentsOnBeneficiary;
  String? transSessionId;
  String? transactionStatus;
  int? payoutTransactionCount;
  int? smsBeneConfirmationOtp;
  int? smsRemitterConfirmationOtp;
  int? zeepayId;
  String? channel;
  bool? isScheduledTransaction;
  bool? isOffline;
  bool? isActive;
  String? createdAt;
  String? processedAt;
  BeneData? beneData;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['remitter_id'] = remitterId;
    map['partner_id'] = partnerId;
    map['payment_type_pi'] = paymentTypePi;
    map['beneficiary_id'] = beneficiaryId;
    map['source_country'] = sourceCountry;
    map['destination_country'] = destinationCountry;
    map['source_currency'] = sourceCurrency;
    map['destination_currency'] = destinationCurrency;
    map['destination_account'] = destinationAccount;
    map['payer_name'] = payerName;
    map['amount_type'] = amountType;
    map['source_amount'] = sourceAmount;
    map['destination_amount'] = destinationAmount;
    map['pay_in_trans_id'] = payInTransId;
    map['pay_out_trans_id'] = payOutTransId;
    map['purpose'] = purpose;
    map['source_of_income'] = sourceOfIncome;
    map['account_item_number'] = accountItemNumber;
    map['transfer_type_po'] = transferTypePo;
    map['utility_bill'] = utilityBill;
    map['tax'] = tax;
    map['rate'] = rate;
    map['total_fee'] = totalFee;
    map['head_office_fee'] = headOfficeFee;
    map['amount_paid'] = amountPaid;
    map['reason'] = reason;
    map['agent_id'] = agentId;
    map['agent_commision'] = agentCommision;
    map['agent_fee'] = agentFee;
    map['agent_transaction_reference_number'] = agentTransactionReferenceNumber;
    map['compliance_needed'] = complianceNeeded;
    map['compliance_checked'] = complianceChecked;
    map['ext_compliance_needed'] = extComplianceNeeded;
    map['ext_compliance_checked'] = extComplianceChecked;
    map['payment_token'] = paymentToken;
    map['remitter_wallet_currency'] = remitterWalletCurrency;
    map['service_level'] = serviceLevel;
    map['promotion_code'] = promotionCode;
    map['sms_confirmation'] = smsConfirmation;
    map['sms_notification'] = smsNotification;
    map['sms_mobile'] = smsMobile;
    map['sms_benef_confirmation'] = smsBenefConfirmation;
    map['sms_benef_mobile'] = smsBenefMobile;
    map['utility_bill_invoice'] = utilityBillInvoice;
    map['utility_bill_description'] = utilityBillDescription;
    map['comments_on_beneficiary'] = commentsOnBeneficiary;
    map['trans_session_id'] = transSessionId;
    map['transaction_status'] = transactionStatus;
    map['payout_transaction_count'] = payoutTransactionCount;
    map['sms_bene_confirmation_otp'] = smsBeneConfirmationOtp;
    map['sms_remitter_confirmation_otp'] = smsRemitterConfirmationOtp;
    map['zeepay_id'] = zeepayId;
    map['channel'] = channel;
    map['is_scheduled_transaction'] = isScheduledTransaction;
    map['is_offline'] = isOffline;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['processed_at'] = processedAt;
    if (beneData != null) {
      map['bene_data'] = beneData?.toJson();
    }
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// bene_id : 947
/// bene_first_name : "BeneTest"
/// bene_middle_name : ""
/// bene_last_name : "Create"
/// bene_email : ""
/// gender : ""
/// bene_date_of_birth : ""
/// bene_mobile_code : "+252"
/// bene_mobile_number : "123457678"
/// bene_address : "address "
/// bene_city : "london"
/// bene_post_code : ""
/// avatar : ""
/// remitter_beneficiary_relation : "Brother"
/// benificiary_country : "SOL"
/// transfer_type_po : ""
/// isactive : false
/// remitter_id : 276
/// partner_id : 19
/// purpose : ""
/// bene_card_number : ""
/// bene_bank_details : null
/// routing_number : ""
/// receiver_msisdn : ""
/// bene_billpay_accountno : ""
/// collection_point_id : 34
/// collection_point_name : "XASAN KURUSOW /MOHAMUD OSMAN"
/// collection_point_code : "BAKAALSO"
/// collection_point_proc_bank : "Bank Bakaal Somalia"
/// collection_point_address : "AFGOOYE"
/// collection_point_city : "AFGOOYE"
/// collection_point_state : "AFGOOYE"
/// mobile_transfer_number : "888555555"
/// mobile_transfer_network : "E Dahab"
/// mobile_transfer_network_id : 33
/// aml_status : "AML-SENT"
/// is_favorite : true
/// is_active : true
/// created_at : "2024-05-09T11:23:36.399967Z"
/// updated_at : "2024-05-15T04:02:55.586495Z"

class BeneData {
  BeneData({
    this.beneId,
    this.beneFirstName,
    this.beneMiddleName,
    this.beneLastName,
    this.beneEmail,
    this.gender,
    this.beneDateOfBirth,
    this.beneMobileCode,
    this.beneMobileNumber,
    this.beneAddress,
    this.beneCity,
    this.benePostCode,
    this.avatar,
    this.remitterBeneficiaryRelation,
    this.benificiaryCountry,
    this.transferTypePo,
    this.isactive,
    this.remitterId,
    this.partnerId,
    this.purpose,
    this.beneCardNumber,
    this.beneBankDetails,
    this.routingNumber,
    this.receiverMsisdn,
    this.beneBillpayAccountno,
    this.collectionPointId,
    this.collectionPointName,
    this.collectionPointCode,
    this.collectionPointProcBank,
    this.collectionPointAddress,
    this.collectionPointCity,
    this.collectionPointState,
    this.mobileTransferNumber,
    this.mobileTransferNetwork,
    this.mobileTransferNetworkId,
    this.amlStatus,
    this.isFavorite,
    this.isActive,
    this.createdAt,
    this.updatedAt,});

  BeneData.fromJson(dynamic json) {
    beneId = json['bene_id'];
    beneFirstName = json['bene_first_name'];
    beneMiddleName = json['bene_middle_name'];
    beneLastName = json['bene_last_name'];
    beneEmail = json['bene_email'];
    gender = json['gender'];
    beneDateOfBirth = json['bene_date_of_birth'];
    beneMobileCode = json['bene_mobile_code'];
    beneMobileNumber = json['bene_mobile_number'];
    beneAddress = json['bene_address'];
    beneCity = json['bene_city'];
    benePostCode = json['bene_post_code'];
    avatar = json['avatar'];
    remitterBeneficiaryRelation = json['remitter_beneficiary_relation'];
    benificiaryCountry = json['benificiary_country'];
    transferTypePo = json['transfer_type_po'];
    isactive = json['isactive'];
    remitterId = json['remitter_id'];
    partnerId = json['partner_id'];
    purpose = json['purpose'];
    beneCardNumber = json['bene_card_number'];
    beneBankDetails = json['bene_bank_details'];
    routingNumber = json['routing_number'];
    receiverMsisdn = json['receiver_msisdn'];
    beneBillpayAccountno = json['bene_billpay_accountno'];
    collectionPointId = json['collection_point_id'];
    collectionPointName = json['collection_point_name'];
    collectionPointCode = json['collection_point_code'];
    collectionPointProcBank = json['collection_point_proc_bank'];
    collectionPointAddress = json['collection_point_address'];
    collectionPointCity = json['collection_point_city'];
    collectionPointState = json['collection_point_state'];
    mobileTransferNumber = json['mobile_transfer_number'];
    mobileTransferNetwork = json['mobile_transfer_network'];
    mobileTransferNetworkId = json['mobile_transfer_network_id'];
    amlStatus = json['aml_status'];
    isFavorite = json['is_favorite'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? beneId;
  String? beneFirstName;
  String? beneMiddleName;
  String? beneLastName;
  String? beneEmail;
  String? gender;
  String? beneDateOfBirth;
  String? beneMobileCode;
  String? beneMobileNumber;
  String? beneAddress;
  String? beneCity;
  String? benePostCode;
  String? avatar;
  String? remitterBeneficiaryRelation;
  String? benificiaryCountry;
  String? transferTypePo;
  bool? isactive;
  int? remitterId;
  int? partnerId;
  String? purpose;
  String? beneCardNumber;
  dynamic beneBankDetails;
  String? routingNumber;
  String? receiverMsisdn;
  String? beneBillpayAccountno;
  int? collectionPointId;
  String? collectionPointName;
  String? collectionPointCode;
  String? collectionPointProcBank;
  String? collectionPointAddress;
  String? collectionPointCity;
  String? collectionPointState;
  String? mobileTransferNumber;
  String? mobileTransferNetwork;
  int? mobileTransferNetworkId;
  String? amlStatus;
  bool? isFavorite;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bene_id'] = beneId;
    map['bene_first_name'] = beneFirstName;
    map['bene_middle_name'] = beneMiddleName;
    map['bene_last_name'] = beneLastName;
    map['bene_email'] = beneEmail;
    map['gender'] = gender;
    map['bene_date_of_birth'] = beneDateOfBirth;
    map['bene_mobile_code'] = beneMobileCode;
    map['bene_mobile_number'] = beneMobileNumber;
    map['bene_address'] = beneAddress;
    map['bene_city'] = beneCity;
    map['bene_post_code'] = benePostCode;
    map['avatar'] = avatar;
    map['remitter_beneficiary_relation'] = remitterBeneficiaryRelation;
    map['benificiary_country'] = benificiaryCountry;
    map['transfer_type_po'] = transferTypePo;
    map['isactive'] = isactive;
    map['remitter_id'] = remitterId;
    map['partner_id'] = partnerId;
    map['purpose'] = purpose;
    map['bene_card_number'] = beneCardNumber;
    map['bene_bank_details'] = beneBankDetails;
    map['routing_number'] = routingNumber;
    map['receiver_msisdn'] = receiverMsisdn;
    map['bene_billpay_accountno'] = beneBillpayAccountno;
    map['collection_point_id'] = collectionPointId;
    map['collection_point_name'] = collectionPointName;
    map['collection_point_code'] = collectionPointCode;
    map['collection_point_proc_bank'] = collectionPointProcBank;
    map['collection_point_address'] = collectionPointAddress;
    map['collection_point_city'] = collectionPointCity;
    map['collection_point_state'] = collectionPointState;
    map['mobile_transfer_number'] = mobileTransferNumber;
    map['mobile_transfer_network'] = mobileTransferNetwork;
    map['mobile_transfer_network_id'] = mobileTransferNetworkId;
    map['aml_status'] = amlStatus;
    map['is_favorite'] = isFavorite;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 0
/// remitter_id : 0
/// payer_name : ""
/// destination_account : ""
/// source_country : ""
/// source_currency : ""
/// destination_country : ""
/// destination_currency : ""
/// send_amount : 0
/// receive_amount : 0
/// created_at : "0001-01-01T00:00:00Z"
/// updated_at : "0001-01-01T00:00:00Z"

class BillpaymentData {
  BillpaymentData({
    this.id,
    this.remitterId,
    this.payerName,
    this.destinationAccount,
    this.sourceCountry,
    this.sourceCurrency,
    this.destinationCountry,
    this.destinationCurrency,
    this.sendAmount,
    this.receiveAmount,
    this.createdAt,
    this.updatedAt,});

  BillpaymentData.fromJson(dynamic json) {
    id = json['id'];
    remitterId = json['remitter_id'];
    payerName = json['payer_name'];
    destinationAccount = json['destination_account'];
    sourceCountry = json['source_country'];
    sourceCurrency = json['source_currency'];
    destinationCountry = json['destination_country'];
    destinationCurrency = json['destination_currency'];
    sendAmount = json['send_amount'];
    receiveAmount = json['receive_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? remitterId;
  String? payerName;
  String? destinationAccount;
  String? sourceCountry;
  String? sourceCurrency;
  String? destinationCountry;
  String? destinationCurrency;
  int? sendAmount;
  int? receiveAmount;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['remitter_id'] = remitterId;
    map['payer_name'] = payerName;
    map['destination_account'] = destinationAccount;
    map['source_country'] = sourceCountry;
    map['source_currency'] = sourceCurrency;
    map['destination_country'] = destinationCountry;
    map['destination_currency'] = destinationCurrency;
    map['send_amount'] = sendAmount;
    map['receive_amount'] = receiveAmount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// bene_id : 947
/// bene_first_name : "BeneTest"
/// bene_middle_name : ""
/// bene_last_name : "Create"
/// bene_email : ""
/// gender : ""
/// bene_date_of_birth : ""
/// bene_mobile_code : "+252"
/// bene_mobile_number : "123457678"
/// bene_address : "address "
/// bene_city : "london"
/// bene_post_code : ""
/// avatar : ""
/// remitter_beneficiary_relation : "Brother"
/// benificiary_country : "SOL"
/// transfer_type_po : ""
/// isactive : false
/// remitter_id : 276
/// partner_id : 19
/// purpose : ""
/// bene_card_number : ""
/// bene_bank_details : null
/// routing_number : ""
/// receiver_msisdn : ""
/// bene_billpay_accountno : ""
/// collection_point_id : 34
/// collection_point_name : "XASAN KURUSOW /MOHAMUD OSMAN"
/// collection_point_code : "BAKAALSO"
/// collection_point_proc_bank : "Bank Bakaal Somalia"
/// collection_point_address : "AFGOOYE"
/// collection_point_city : "AFGOOYE"
/// collection_point_state : "AFGOOYE"
/// mobile_transfer_number : "888555555"
/// mobile_transfer_network : "E Dahab"
/// mobile_transfer_network_id : 33
/// aml_status : "AML-SENT"
/// is_favorite : true
/// is_active : true
/// created_at : "2024-05-09T11:23:36.399967Z"
/// updated_at : "2024-05-15T04:03:21.261984847Z"

class BeneficiaryData {
  BeneficiaryData({
    this.beneId,
    this.beneFirstName,
    this.beneMiddleName,
    this.beneLastName,
    this.beneEmail,
    this.gender,
    this.beneDateOfBirth,
    this.beneMobileCode,
    this.beneMobileNumber,
    this.beneAddress,
    this.beneCity,
    this.benePostCode,
    this.avatar,
    this.remitterBeneficiaryRelation,
    this.benificiaryCountry,
    this.transferTypePo,
    this.isactive,
    this.remitterId,
    this.partnerId,
    this.purpose,
    this.beneCardNumber,
    this.beneBankDetails,
    this.routingNumber,
    this.receiverMsisdn,
    this.beneBillpayAccountno,
    this.collectionPointId,
    this.collectionPointName,
    this.collectionPointCode,
    this.collectionPointProcBank,
    this.collectionPointAddress,
    this.collectionPointCity,
    this.collectionPointState,
    this.mobileTransferNumber,
    this.mobileTransferNetwork,
    this.mobileTransferNetworkId,
    this.amlStatus,
    this.isFavorite,
    this.isActive,
    this.createdAt,
    this.updatedAt,});

  BeneficiaryData.fromJson(dynamic json) {
    beneId = json['bene_id'];
    beneFirstName = json['bene_first_name'];
    beneMiddleName = json['bene_middle_name'];
    beneLastName = json['bene_last_name'];
    beneEmail = json['bene_email'];
    gender = json['gender'];
    beneDateOfBirth = json['bene_date_of_birth'];
    beneMobileCode = json['bene_mobile_code'];
    beneMobileNumber = json['bene_mobile_number'];
    beneAddress = json['bene_address'];
    beneCity = json['bene_city'];
    benePostCode = json['bene_post_code'];
    avatar = json['avatar'];
    remitterBeneficiaryRelation = json['remitter_beneficiary_relation'];
    benificiaryCountry = json['benificiary_country'];
    transferTypePo = json['transfer_type_po'];
    isactive = json['isactive'];
    remitterId = json['remitter_id'];
    partnerId = json['partner_id'];
    purpose = json['purpose'];
    beneCardNumber = json['bene_card_number'];
    beneBankDetails = json['bene_bank_details'];
    routingNumber = json['routing_number'];
    receiverMsisdn = json['receiver_msisdn'];
    beneBillpayAccountno = json['bene_billpay_accountno'];
    collectionPointId = json['collection_point_id'];
    collectionPointName = json['collection_point_name'];
    collectionPointCode = json['collection_point_code'];
    collectionPointProcBank = json['collection_point_proc_bank'];
    collectionPointAddress = json['collection_point_address'];
    collectionPointCity = json['collection_point_city'];
    collectionPointState = json['collection_point_state'];
    mobileTransferNumber = json['mobile_transfer_number'];
    mobileTransferNetwork = json['mobile_transfer_network'];
    mobileTransferNetworkId = json['mobile_transfer_network_id'];
    amlStatus = json['aml_status'];
    isFavorite = json['is_favorite'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? beneId;
  String? beneFirstName;
  String? beneMiddleName;
  String? beneLastName;
  String? beneEmail;
  String? gender;
  String? beneDateOfBirth;
  String? beneMobileCode;
  String? beneMobileNumber;
  String? beneAddress;
  String? beneCity;
  String? benePostCode;
  String? avatar;
  String? remitterBeneficiaryRelation;
  String? benificiaryCountry;
  String? transferTypePo;
  bool? isactive;
  int? remitterId;
  int? partnerId;
  String? purpose;
  String? beneCardNumber;
  dynamic beneBankDetails;
  String? routingNumber;
  String? receiverMsisdn;
  String? beneBillpayAccountno;
  int? collectionPointId;
  String? collectionPointName;
  String? collectionPointCode;
  String? collectionPointProcBank;
  String? collectionPointAddress;
  String? collectionPointCity;
  String? collectionPointState;
  String? mobileTransferNumber;
  String? mobileTransferNetwork;
  int? mobileTransferNetworkId;
  String? amlStatus;
  bool? isFavorite;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bene_id'] = beneId;
    map['bene_first_name'] = beneFirstName;
    map['bene_middle_name'] = beneMiddleName;
    map['bene_last_name'] = beneLastName;
    map['bene_email'] = beneEmail;
    map['gender'] = gender;
    map['bene_date_of_birth'] = beneDateOfBirth;
    map['bene_mobile_code'] = beneMobileCode;
    map['bene_mobile_number'] = beneMobileNumber;
    map['bene_address'] = beneAddress;
    map['bene_city'] = beneCity;
    map['bene_post_code'] = benePostCode;
    map['avatar'] = avatar;
    map['remitter_beneficiary_relation'] = remitterBeneficiaryRelation;
    map['benificiary_country'] = benificiaryCountry;
    map['transfer_type_po'] = transferTypePo;
    map['isactive'] = isactive;
    map['remitter_id'] = remitterId;
    map['partner_id'] = partnerId;
    map['purpose'] = purpose;
    map['bene_card_number'] = beneCardNumber;
    map['bene_bank_details'] = beneBankDetails;
    map['routing_number'] = routingNumber;
    map['receiver_msisdn'] = receiverMsisdn;
    map['bene_billpay_accountno'] = beneBillpayAccountno;
    map['collection_point_id'] = collectionPointId;
    map['collection_point_name'] = collectionPointName;
    map['collection_point_code'] = collectionPointCode;
    map['collection_point_proc_bank'] = collectionPointProcBank;
    map['collection_point_address'] = collectionPointAddress;
    map['collection_point_city'] = collectionPointCity;
    map['collection_point_state'] = collectionPointState;
    map['mobile_transfer_number'] = mobileTransferNumber;
    map['mobile_transfer_network'] = mobileTransferNetwork;
    map['mobile_transfer_network_id'] = mobileTransferNetworkId;
    map['aml_status'] = amlStatus;
    map['is_favorite'] = isFavorite;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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