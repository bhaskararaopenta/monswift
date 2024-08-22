class GetDeliveryBanksModel {
  String? message;
  bool? success;
  List<Response>? response;

  GetDeliveryBanksModel({this.message, this.success, this.response});

  GetDeliveryBanksModel.fromJson(Map<String, dynamic> json) {
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
  String? city;
  String? name;
  String? state;
  String? address;
  int? bankId;
  String? bankCode;
  String? telephone;
  int? countryId;
  String? swiftCode;
  String? accountNumberMask;

  Response(
      {this.city,
        this.name,
        this.state,
        this.address,
        this.bankId,
        this.bankCode,
        this.telephone,
        this.countryId,
        this.swiftCode,
        this.accountNumberMask});

  Response.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    name = json['name'];
    state = json['state'];
    address = json['address'];
    bankId = json['bank_id'];
    bankCode = json['bank_code'];
    telephone = json['telephone'];
    countryId = json['country_id'];
    swiftCode = json['swift_code'];
    accountNumberMask = json['account_number_mask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['name'] = this.name;
    data['state'] = this.state;
    data['address'] = this.address;
    data['bank_id'] = this.bankId;
    data['bank_code'] = this.bankCode;
    data['telephone'] = this.telephone;
    data['country_id'] = this.countryId;
    data['swift_code'] = this.swiftCode;
    data['account_number_mask'] = this.accountNumberMask;
    return data;
  }
}
