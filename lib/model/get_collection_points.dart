class GetCollectionPoints {
  GetCollectionPoints({
      this.message, 
      this.success, 
      this.response,});

  GetCollectionPoints.fromJson(dynamic json) {
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

/// id : 255
/// partner_id : 19
/// source_country : "GBR"
/// destination_country : "SOM"
/// collection_id : 104
/// name : "AFGOOYE"
/// bank : "Bank bakaal somalia"
/// delivery_bank : 1286
/// address : "AFGOOYE"
/// city : "AFGOOYE"
/// state : "Afgooye"
/// code : "BAKAALSO"
/// telephone : ""
/// fax : ""
/// email : ""
/// working_hours : ""
/// contact_person : "XASAN KURUSOW /MOHAMUD OSMAN"
/// default_in_country : "f"
/// enabled : "t"
/// collection_pin_prefix : ""
/// rate_markup : 0
/// restrict_destination_currencies : "f"
/// allowed_destination_currencies : ""
/// is_active : true
/// created_at : "2024-03-14T09:48:28.053819Z"
/// updated_at : "2024-03-14T09:48:28.053819Z"

class Response {
  Response({
      this.id, 
      this.partnerId, 
      this.sourceCountry, 
      this.destinationCountry, 
      this.collectionId, 
      this.name, 
      this.bank, 
      this.deliveryBank, 
      this.address, 
      this.city, 
      this.state, 
      this.code, 
      this.telephone, 
      this.fax, 
      this.email, 
      this.workingHours, 
      this.contactPerson, 
      this.defaultInCountry, 
      this.enabled, 
      this.collectionPinPrefix, 
      this.rateMarkup, 
      this.restrictDestinationCurrencies, 
      this.allowedDestinationCurrencies, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    partnerId = json['partner_id'];
    sourceCountry = json['source_country'];
    destinationCountry = json['destination_country'];
    collectionId = json['collection_id'];
    name = json['name'];
    bank = json['bank'];
    deliveryBank = json['delivery_bank'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    code = json['code'];
    telephone = json['telephone'];
    fax = json['fax'];
    email = json['email'];
    workingHours = json['working_hours'];
    contactPerson = json['contact_person'];
    defaultInCountry = json['default_in_country'];
    enabled = json['enabled'];
    collectionPinPrefix = json['collection_pin_prefix'];
    rateMarkup = json['rate_markup'];
    restrictDestinationCurrencies = json['restrict_destination_currencies'];
    allowedDestinationCurrencies = json['allowed_destination_currencies'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? partnerId;
  String? sourceCountry;
  String? destinationCountry;
  int? collectionId;
  String? name;
  String? bank;
  int? deliveryBank;
  String? address;
  String? city;
  String? state;
  String? code;
  String? telephone;
  String? fax;
  String? email;
  String? workingHours;
  String? contactPerson;
  String? defaultInCountry;
  String? enabled;
  String? collectionPinPrefix;
  int? rateMarkup;
  String? restrictDestinationCurrencies;
  String? allowedDestinationCurrencies;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['partner_id'] = partnerId;
    map['source_country'] = sourceCountry;
    map['destination_country'] = destinationCountry;
    map['collection_id'] = collectionId;
    map['name'] = name;
    map['bank'] = bank;
    map['delivery_bank'] = deliveryBank;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['code'] = code;
    map['telephone'] = telephone;
    map['fax'] = fax;
    map['email'] = email;
    map['working_hours'] = workingHours;
    map['contact_person'] = contactPerson;
    map['default_in_country'] = defaultInCountry;
    map['enabled'] = enabled;
    map['collection_pin_prefix'] = collectionPinPrefix;
    map['rate_markup'] = rateMarkup;
    map['restrict_destination_currencies'] = restrictDestinationCurrencies;
    map['allowed_destination_currencies'] = allowedDestinationCurrencies;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}