/// Message : "Data Fetched Successfully"
/// Success : true
/// response : [{"branch_code":"BAKAALSO","city":"Any city","delivery_bank":1297,"id":8389,"manager":"N/A","name":"SomBank","state":"Any state","telephone":"N/A","created_at":"0001-01-01T00:00:00Z","updated_at":"0001-01-01T00:00:00Z"}]

class GetDeliveryBankBranch {
  GetDeliveryBankBranch({
      this.message, 
      this.success, 
      this.response,});

  GetDeliveryBankBranch.fromJson(dynamic json) {
    message = json['Message'];
    success = json['Success'];
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  String? message;
  bool? success;
  List<Response>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Success'] = success;
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// branch_code : "BAKAALSO"
/// city : "Any city"
/// delivery_bank : 1297
/// id : 8389
/// manager : "N/A"
/// name : "SomBank"
/// state : "Any state"
/// telephone : "N/A"
/// created_at : "0001-01-01T00:00:00Z"
/// updated_at : "0001-01-01T00:00:00Z"

class Response {
  Response({
      this.branchCode, 
      this.city, 
      this.deliveryBank, 
      this.id, 
      this.manager, 
      this.name, 
      this.state, 
      this.telephone, 
      this.createdAt, 
      this.updatedAt,});

  Response.fromJson(dynamic json) {
    branchCode = json['branch_code'];
    city = json['city'];
    deliveryBank = json['delivery_bank'];
    id = json['id'];
    manager = json['manager'];
    name = json['name'];
    state = json['state'];
    telephone = json['telephone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? branchCode;
  String? city;
  int? deliveryBank;
  int? id;
  String? manager;
  String? name;
  String? state;
  String? telephone;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branch_code'] = branchCode;
    map['city'] = city;
    map['delivery_bank'] = deliveryBank;
    map['id'] = id;
    map['manager'] = manager;
    map['name'] = name;
    map['state'] = state;
    map['telephone'] = telephone;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}