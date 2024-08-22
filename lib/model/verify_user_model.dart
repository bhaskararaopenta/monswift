/// first_name : "firstName"
/// middle_name : ""
/// last_name : "Lastname"
/// gender : "M"
/// nationality : "GBR"
/// date_of_birth : "31-01-1999"
/// mobile_number : "+449502145505"
/// address1 : "address_1"
/// address2 : "address_2"
/// city : "city"
/// postal_code : "BN12W34"
/// documents : [{"document_type":"ID_CARD","document_expiry_date":"21-08-2025","document_number":"12345","document_section":"document-back","image":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA7oAAAHICAYAAABgcZa"},{"document_type":"","document_expiry_date":"","document_number":"","document_section":"","image":""}]

class VerifyUserModel {
  VerifyUserModel({
      this.firstName, 
      this.middleName, 
      this.lastName, 
      this.gender, 
      this.nationality, 
      this.dateOfBirth, 
      this.mobileNumber, 
      this.address1, 
      this.address2, 
      this.city, 
      this.postalCode, 
      this.documents,});

  VerifyUserModel.fromJson(dynamic json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    nationality = json['nationality'];
    dateOfBirth = json['date_of_birth'];
    mobileNumber = json['mobile_number'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    postalCode = json['postal_code'];
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        documents?.add(Documents.fromJson(v));
      });
    }
  }
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? nationality;
  String? dateOfBirth;
  String? mobileNumber;
  String? address1;
  String? address2;
  String? city;
  String? postalCode;
  List<Documents>? documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['middle_name'] = middleName;
    map['last_name'] = lastName;
    map['gender'] = gender;
    map['nationality'] = nationality;
    map['date_of_birth'] = dateOfBirth;
    map['mobile_number'] = mobileNumber;
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['postal_code'] = postalCode;
    if (documents != null) {
      map['documents'] = documents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// document_type : "ID_CARD"
/// document_expiry_date : "21-08-2025"
/// document_number : "12345"
/// document_section : "document-back"
/// image : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA7oAAAHICAYAAABgcZa"

class Documents {
  Documents({
      this.documentType, 
      this.documentExpiryDate, 
      this.documentNumber, 
      this.documentSection, 
      this.image,});

  Documents.fromJson(dynamic json) {
    documentType = json['document_type'];
    documentExpiryDate = json['document_expiry_date'];
    documentNumber = json['document_number'];
    documentSection = json['document_section'];
    image = json['image'];
  }
  String? documentType;
  String? documentExpiryDate;
  String? documentNumber;
  String? documentSection;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_type'] = documentType;
    map['document_expiry_date'] = documentExpiryDate;
    map['document_number'] = documentNumber;
    map['document_section'] = documentSection;
    map['image'] = image;
    return map;
  }

}