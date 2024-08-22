// To parse this JSON data, do
//
//     final verifyCodeModel = verifyCodeModelFromJson(jsonString);

import 'dart:convert';

VerifyCodeModel verifyCodeModelFromJson(String str) => VerifyCodeModel.fromJson(json.decode(str));

String verifyCodeModelToJson(VerifyCodeModel data) => json.encode(data.toJson());

class VerifyCodeModel {
  Error? error;
  bool success;

  VerifyCodeModel({
    this.error,
    required this.success,
  });

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) => VerifyCodeModel(
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "success": success,
  };
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
