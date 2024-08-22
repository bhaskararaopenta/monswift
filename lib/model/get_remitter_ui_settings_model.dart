/// message : "Data Fetched Successfully"
/// response : {"id":2,"partner_id":19,"source_country":"Australia","terms_and_conditions":"https://www.nationremit.com/terms-and-conditions/","privacy_policy":"hwwtp","is_active":true,"created_at":"2024-05-31T01:43:32.638599Z","updated_at":"2024-05-31T01:43:32.638599Z"}
/// success : true

class GetRemitterUiSettingsModel {
  GetRemitterUiSettingsModel({
      this.message, 
      this.response, 
      this.success,this.error});

  GetRemitterUiSettingsModel.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
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
    if (this.error != null) {
      map['error'] = this.error!.toJson();
    }
    return map;
  }

}

/// id : 2
/// partner_id : 19
/// source_country : "Australia"
/// terms_and_conditions : "https://www.nationremit.com/terms-and-conditions/"
/// privacy_policy : "hwwtp"
/// is_active : true
/// created_at : "2024-05-31T01:43:32.638599Z"
/// updated_at : "2024-05-31T01:43:32.638599Z"

class Response {
  Response({
      this.id, 
      this.partnerId, 
      this.sourceCountry, 
      this.termsAndConditions, 
      this.privacyPolicy, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    partnerId = json['partner_id'];
    sourceCountry = json['source_country'];
    termsAndConditions = json['terms_and_conditions'];
    privacyPolicy = json['privacy_policy'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? partnerId;
  String? sourceCountry;
  String? termsAndConditions;
  String? privacyPolicy;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['partner_id'] = partnerId;
    map['source_country'] = sourceCountry;
    map['terms_and_conditions'] = termsAndConditions;
    map['privacy_policy'] = privacyPolicy;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Error {
  String? message;
  int? statusCode;

  Error({this.message, this.statusCode});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}