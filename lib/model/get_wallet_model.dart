/// Message : "Data Fetched Successfully"
/// Success : true
/// response : {"id":3,"remitter_id":167,"wallet_id":"4F0C5627-7837-46CA-8F91-982378B7EE17","partner_id":19,"partner_wallet_id":1,"balance":110,"currency":"GBP","country":"GBR","is_active":true,"is_deleted":false,"created_at":"2024-04-16T10:55:41.628672Z","updated_at":"2024-04-16T10:55:41.628672Z"}

class GetWalletModel {
  GetWalletModel({
      this.message, 
      this.success, 
      this.response,this.error});

  GetWalletModel.fromJson(dynamic json) {
    message = json['Message'];
    success = json['Success'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    error=json["error"] == null ? null : Error.fromJson(json["error"]);

  }
  String? message;
  bool? success;
  Response? response;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Success'] = success;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    if (error != null) map['error']= error;
    return map;
  }

}

/// id : 3
/// remitter_id : 167
/// wallet_id : "4F0C5627-7837-46CA-8F91-982378B7EE17"
/// partner_id : 19
/// partner_wallet_id : 1
/// balance : 110
/// currency : "GBP"
/// country : "GBR"
/// is_active : true
/// is_deleted : false
/// created_at : "2024-04-16T10:55:41.628672Z"
/// updated_at : "2024-04-16T10:55:41.628672Z"

class Response {
  Response({
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

  Response.fromJson(dynamic json) {
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