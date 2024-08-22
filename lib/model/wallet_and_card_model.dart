/// message : "Data Fetched Successfully"
/// response : {"cards":[{"id":49,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"59-9-3692890"},{"id":50,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"56-9-3647344"},{"id":51,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"55-9-3645344"},{"id":56,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"56-9-3660427"}],"wallets":[{"id":1,"remitter_id":276,"wallet_id":"324DDFE3-CC3F-4441-B378-2837D61ED7EC","partner_id":19,"partner_wallet_id":1,"balance":0,"currency":"GBP","country":"GBR","is_active":true,"is_deleted":false,"created_at":"2024-04-11T14:11:13.519871Z","updated_at":"2024-04-11T14:11:13.519871Z"}]}
/// success : true

class WalletAndCardModel {
  WalletAndCardModel({
      this.message, 
      this.response, 
      this.success,});

  WalletAndCardModel.fromJson(dynamic json) {
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

/// cards : [{"id":49,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"59-9-3692890"},{"id":50,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"56-9-3647344"},{"id":51,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"55-9-3645344"},{"id":56,"is_active":true,"masked_card_number":"411111######1111","payment_card":"VISA","remitter_id":276,"remitter_name":"Thiru Gora","tp_transaction_reference":"56-9-3660427"}]
/// wallets : [{"id":1,"remitter_id":276,"wallet_id":"324DDFE3-CC3F-4441-B378-2837D61ED7EC","partner_id":19,"partner_wallet_id":1,"balance":0,"currency":"GBP","country":"GBR","is_active":true,"is_deleted":false,"created_at":"2024-04-11T14:11:13.519871Z","updated_at":"2024-04-11T14:11:13.519871Z"}]

class Response {
  Response({
      this.cards, 
      this.wallets,});

  Response.fromJson(dynamic json) {
    if (json['cards'] != null) {
      cards = [];
      json['cards'].forEach((v) {
        cards?.add(Cards.fromJson(v));
      });
    }
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }
  }
  List<Cards>? cards;
  List<Wallets>? wallets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cards != null) {
      map['cards'] = cards?.map((v) => v.toJson()).toList();
    }
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// remitter_id : 276
/// wallet_id : "324DDFE3-CC3F-4441-B378-2837D61ED7EC"
/// partner_id : 19
/// partner_wallet_id : 1
/// balance : 0
/// currency : "GBP"
/// country : "GBR"
/// is_active : true
/// is_deleted : false
/// created_at : "2024-04-11T14:11:13.519871Z"
/// updated_at : "2024-04-11T14:11:13.519871Z"

class Wallets {
  Wallets({
      this.id, 
      this.remitterId, 
      this.walletId, 
      this.partnerId, 
      this.partnerWalletId, 
      this.balance, 
      this.currency, 
      this.country, 
      this.isActive, 
      this.isDeleted, 
      this.createdAt, 
      this.updatedAt,});

  Wallets.fromJson(dynamic json) {
    id = json['id'];
    remitterId = json['remitter_id'];
    walletId = json['wallet_id'];
    partnerId = json['partner_id'];
    partnerWalletId = json['partner_wallet_id'];
    balance = json['balance'];
    currency = json['currency'];
    country = json['country'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? remitterId;
  String? walletId;
  int? partnerId;
  int? partnerWalletId;
  int? balance;
  String? currency;
  String? country;
  bool? isActive;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['remitter_id'] = remitterId;
    map['wallet_id'] = walletId;
    map['partner_id'] = partnerId;
    map['partner_wallet_id'] = partnerWalletId;
    map['balance'] = balance;
    map['currency'] = currency;
    map['country'] = country;
    map['is_active'] = isActive;
    map['is_deleted'] = isDeleted;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 49
/// is_active : true
/// masked_card_number : "411111######1111"
/// payment_card : "VISA"
/// remitter_id : 276
/// remitter_name : "Thiru Gora"
/// tp_transaction_reference : "59-9-3692890"

class Cards {
  Cards({
      this.id, 
      this.isActive, 
      this.maskedCardNumber, 
      this.paymentCard, 
      this.remitterId, 
      this.remitterName, 
      this.tpTransactionReference,});

  Cards.fromJson(dynamic json) {
    id = json['id'];
    isActive = json['is_active'];
    maskedCardNumber = json['masked_card_number'];
    paymentCard = json['payment_card'];
    remitterId = json['remitter_id'];
    remitterName = json['remitter_name'];
    tpTransactionReference = json['tp_transaction_reference'];
  }
  int? id;
  bool? isActive;
  String? maskedCardNumber;
  String? paymentCard;
  int? remitterId;
  String? remitterName;
  String? tpTransactionReference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['is_active'] = isActive;
    map['masked_card_number'] = maskedCardNumber;
    map['payment_card'] = paymentCard;
    map['remitter_id'] = remitterId;
    map['remitter_name'] = remitterName;
    map['tp_transaction_reference'] = tpTransactionReference;
    return map;
  }

}