/// bene_id : 820
/// bene_first_name : "sai"
/// bene_middle_name : ""
/// bene_last_name : "sai"
/// bene_email : ""
/// gender : ""
/// bene_date_of_birth : ""
/// bene_mobile_code : "+252"
/// bene_mobile_number : "7993658669"
/// bene_address : "hais"
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
/// mobile_transfer_number : "0496464664"
/// mobile_transfer_network : "E Dahab"
/// mobile_transfer_network_id : 33
/// aml_status : "AML-SENT"
/// is_favorite : true
/// is_active : true
/// created_at : "2024-04-17T09:51:12.733495Z"
/// updated_at : "2024-05-03T04:53:51.544467Z"

class SortedBeneListModel {
  SortedBeneListModel({
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

  SortedBeneListModel.fromJson(dynamic json) {
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