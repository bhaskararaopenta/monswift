class GetCardModel {
  String? message;
  bool? success;
  List<Response>? response;

  GetCardModel({this.message, this.success, this.response});

  GetCardModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Success'] = this.success;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  int? id;
  int? remitterId;
  String? maskedCardNumber;
  String? cardExpiry;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Response(
      {this.id,
        this.remitterId,
        this.maskedCardNumber,
        this.cardExpiry,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remitterId = json['remitter_id'];
    maskedCardNumber = json['masked_card_number'];
    cardExpiry = json['card_expiry'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['remitter_id'] = this.remitterId;
    data['masked_card_number'] = this.maskedCardNumber;
    data['card_expiry'] = this.cardExpiry;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    return data;
  }
}
