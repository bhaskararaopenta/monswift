/// message : "Success"
/// response : {"action_url":"https://xbp.uat.volant-ubicomms.com/api/v1/tp/XBPPT2024000/account-check-response/276","jwt":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTU3NDcyMTQsImlzcyI6Imp3dEBuYXRpb25yZW1pdC5jb20iLCJwYXlsb2FkIjp7ImFjY291bnR0eXBlZGVzY3JpcHRpb24iOiJFQ09NIiwiYmFzZWFtb3VudCI6IjEyIiwiY3JlZGVudGlhbHNvbmZpbGUiOiIxIiwiY3VycmVuY3lpc28zYSI6IkdCUCIsInJlcXVlc3R0eXBlZGVzY3JpcHRpb25zIjpbIkFDQ09VTlRDSEVDSyJdLCJzaXRlcmVmZXJlbmNlIjoidGVzdF9uYXRpb25yZW1pdGx0ZDg2OTIwIn19.O5j1dfh6o8SE5C_hPK_tN11Mlgazdo2r38YplxcRHCE"}
/// success : true

class JwtAccountCheck {
  JwtAccountCheck({
    this.message,
    this.response,
    this.success,});

  JwtAccountCheck.fromJson(dynamic json) {
    message = json['message'];
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
    success = json['success'];
  }
  String? message;
  Response? response;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (response != null) {
      map['response'] = response?.toJson();
    }
    map['success'] = success;
    return map;
  }

}

/// action_url : "https://xbp.uat.volant-ubicomms.com/api/v1/tp/XBPPT2024000/account-check-response/276"
/// jwt : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTU3NDcyMTQsImlzcyI6Imp3dEBuYXRpb25yZW1pdC5jb20iLCJwYXlsb2FkIjp7ImFjY291bnR0eXBlZGVzY3JpcHRpb24iOiJFQ09NIiwiYmFzZWFtb3VudCI6IjEyIiwiY3JlZGVudGlhbHNvbmZpbGUiOiIxIiwiY3VycmVuY3lpc28zYSI6IkdCUCIsInJlcXVlc3R0eXBlZGVzY3JpcHRpb25zIjpbIkFDQ09VTlRDSEVDSyJdLCJzaXRlcmVmZXJlbmNlIjoidGVzdF9uYXRpb25yZW1pdGx0ZDg2OTIwIn19.O5j1dfh6o8SE5C_hPK_tN11Mlgazdo2r38YplxcRHCE"

class Response {
  Response({
    this.actionUrl,
    this.jwt,});

  Response.fromJson(dynamic json) {
    actionUrl = json['action_url'];
    jwt = json['jwt'];
  }
  String? actionUrl;
  String? jwt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action_url'] = actionUrl;
    map['jwt'] = jwt;
    return map;
  }

}