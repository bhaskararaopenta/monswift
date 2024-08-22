/// message : "Success"
/// response : {"action_url":"https://xbp.uat.volant-ubicomms.com/api/v1/tp/XBPPT2024000/sale-response/59855297","card_details":{"id":50,"remitter_id":276,"tp_transaction_reference":"56-9-3647344","masked_card_number":"411111######1111","payment_card":"VISA","created_at":"2024-05-07T02:25:44.114927Z","updated_at":"2024-05-07T02:25:44.114927Z","is_active":true},"jwt":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTU3NDYyNjksImlzcyI6Imp3dEBuYXRpb25yZW1pdC5jb20iLCJwYXlsb2FkIjp7ImFjY291bnR0eXBlZGVzY3JpcHRpb24iOiJFQ09NIiwiYmFzZWFtb3VudCI6IjY3OCIsImNyZWRlbnRpYWxzb25maWxlIjoiMiIsImN1cnJlbmN5aXNvM2EiOiJHQlAiLCJwYXJlbnR0cmFuc2FjdGlvbnJlZmVyZW5jZSI6IjU2LTktMzY0NzM0NCIsInJlcXVlc3R0eXBlZGVzY3JpcHRpb25zIjpbIlRIUkVFRFFVRVJZIiwiQVVUSCJdLCJzaXRlcmVmZXJlbmNlIjoidGVzdF9uYXRpb25yZW1pdGx0ZDg2OTIwIn19.hwRgFM1iYNcXh-Bu41Z51AXcNgJha8Ca39D94V8woJc"}
/// success : true

class JwtTokenSale {
  JwtTokenSale({
    this.message,
    this.response,
    this.success,
    this.error,});

  JwtTokenSale.fromJson(dynamic json) {
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
    map["error"]= error;
    return map;
  }

}

/// action_url : "https://xbp.uat.volant-ubicomms.com/api/v1/tp/XBPPT2024000/sale-response/59855297"
/// card_details : {"id":50,"remitter_id":276,"tp_transaction_reference":"56-9-3647344","masked_card_number":"411111######1111","payment_card":"VISA","created_at":"2024-05-07T02:25:44.114927Z","updated_at":"2024-05-07T02:25:44.114927Z","is_active":true}
/// jwt : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTU3NDYyNjksImlzcyI6Imp3dEBuYXRpb25yZW1pdC5jb20iLCJwYXlsb2FkIjp7ImFjY291bnR0eXBlZGVzY3JpcHRpb24iOiJFQ09NIiwiYmFzZWFtb3VudCI6IjY3OCIsImNyZWRlbnRpYWxzb25maWxlIjoiMiIsImN1cnJlbmN5aXNvM2EiOiJHQlAiLCJwYXJlbnR0cmFuc2FjdGlvbnJlZmVyZW5jZSI6IjU2LTktMzY0NzM0NCIsInJlcXVlc3R0eXBlZGVzY3JpcHRpb25zIjpbIlRIUkVFRFFVRVJZIiwiQVVUSCJdLCJzaXRlcmVmZXJlbmNlIjoidGVzdF9uYXRpb25yZW1pdGx0ZDg2OTIwIn19.hwRgFM1iYNcXh-Bu41Z51AXcNgJha8Ca39D94V8woJc"

class Response {
  Response({
    this.actionUrl,
    this.cardDetails,
    this.jwt,});

  Response.fromJson(dynamic json) {
    actionUrl = json['action_url'];
    cardDetails = json['card_details'] != null ? CardDetails.fromJson(json['card_details']) : null;
    jwt = json['jwt'];
  }
  String? actionUrl;
  CardDetails? cardDetails;
  String? jwt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action_url'] = actionUrl;
    if (cardDetails != null) {
      map['card_details'] = cardDetails?.toJson();
    }
    map['jwt'] = jwt;
    return map;
  }

}

/// id : 50
/// remitter_id : 276
/// tp_transaction_reference : "56-9-3647344"
/// masked_card_number : "411111######1111"
/// payment_card : "VISA"
/// created_at : "2024-05-07T02:25:44.114927Z"
/// updated_at : "2024-05-07T02:25:44.114927Z"
/// is_active : true

class CardDetails {
  CardDetails({
    this.id,
    this.remitterId,
    this.tpTransactionReference,
    this.maskedCardNumber,
    this.paymentCard,
    this.createdAt,
    this.updatedAt,
    this.isActive,});

  CardDetails.fromJson(dynamic json) {
    id = json['id'];
    remitterId = json['remitter_id'];
    tpTransactionReference = json['tp_transaction_reference'];
    maskedCardNumber = json['masked_card_number'];
    paymentCard = json['payment_card'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
  }
  int? id;
  int? remitterId;
  String? tpTransactionReference;
  String? maskedCardNumber;
  String? paymentCard;
  String? createdAt;
  String? updatedAt;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['remitter_id'] = remitterId;
    map['tp_transaction_reference'] = tpTransactionReference;
    map['masked_card_number'] = maskedCardNumber;
    map['payment_card'] = paymentCard;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
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