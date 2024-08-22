/// message : "Card Deleted Successfully"
/// success : true

class IsSuccessModel {
  IsSuccessModel({
      this.message, 
      this.success,});

  IsSuccessModel.fromJson(dynamic json) {
    message = json['message'];
    success = json['success'];
  }
  String? message;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['success'] = success;
    return map;
  }

}