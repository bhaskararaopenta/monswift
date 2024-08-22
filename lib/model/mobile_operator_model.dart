import 'package:nationremit/model/mobile_operator_model.dart';


class MobileOperatorModel {
  String? message;
  bool? success;
  Response? response;

  MobileOperatorModel({this.message, this.success, this.response});

  MobileOperatorModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    success = json['Success'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    data['Success'] = this.success;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<Mnos>? mnos;
  int? count;

  Response({this.mnos, this.count});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['mnos'] != null) {
      mnos = <Mnos>[];
      json['mnos'].forEach((v) {
        mnos!.add(new Mnos.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mnos != null) {
      data['mnos'] = this.mnos!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Mnos {
  int? mobileNetworkId;
  String? name;
  String? code;
  int? countryId;

  Mnos({this.mobileNetworkId, this.name, this.code, this.countryId});

  Mnos.fromJson(Map<String, dynamic> json) {
    mobileNetworkId = json['mobile_network_id'];
    name = json['name'];
    code = json['code'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_network_id'] = this.mobileNetworkId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['country_id'] = this.countryId;
    return data;
  }
}
