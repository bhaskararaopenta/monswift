/// error : {"message":"Invalid token","statusCode":401}
/// success : false

class StoreCardModel {
  StoreCardModel({
      Error? error, 
      bool? success,}){
    _error = error;
    _success = success;
}

  StoreCardModel.fromJson(dynamic json) {
    _error = json['error'] != null ? Error.fromJson(json['error']) : null;
    _success = json['Success'];
  }
  Error? _error;
  bool? _success;

  Error? get error => _error;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_error != null) {
      map['error'] = _error?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}

/// message : "Invalid token"
/// statusCode : 401

class Error {
  Error({
      String? message, 
      int? statusCode,}){
    _message = message;
    _statusCode = statusCode;
}

  Error.fromJson(dynamic json) {
    _message = json['message'];
    _statusCode = json['statusCode'];
  }
  String? _message;
  int? _statusCode;

  String? get message => _message;
  int? get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['statusCode'] = _statusCode;
    return map;
  }

}