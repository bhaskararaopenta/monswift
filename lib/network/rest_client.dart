import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nationremit/network/expection/api_exception.dart';
import 'package:nationremit/network/handlers/response_handler.dart';
import 'package:nationremit/router/router.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'globalkey.dart';

class RestClient {
  ///static const String _contentTypeHeader = 'content-type';
  // static const String _contentLength = 'content-length';
  // static const String _authorizationHeader = 'Authorization';

  static const String _connectionErrorMessage = 'Network Problem';


  // dio instance
  Dio get _dio {
    final dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        //nationRemit
        'Authorization':'Basic eGJwLXBhcnRuZXItdG9rZW46OEZBRjU3NjYtRDJGOC00QjVBLTkxODUtOEMyRkYzMDFDQkVD'
     //vitpay
    //       'Authorization':'Basic eGJwLXBhcnRuZXItdG9rZW46UFY2RVhYOVdWM05ZQTNHNEVZNk1CT05NTE5CNENMMkc='

    // 'Authorization':'Basic PV6EXX9WV3NYA3G4EY6MBONMLNB4CL2G'
      },
    )) ..interceptors.add(RequestsInspectorInterceptor());
    return dio;
  }

  Dio get _dio2 {
    final dio = Dio(BaseOptions(
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    return dio;
  }

  // instance of class singleton
  static final RestClient _singleton = RestClient._internal();
  RestClient._internal();
  factory RestClient() => _singleton;

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          validateStatus: (_) => true,
        ),
      );
      _handleResponse(response);
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    dynamic headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          validateStatus: (_) => true,
        ),
      );
      _handleResponse(response);
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> postWithHeader(
    String uri, {
    dynamic headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio2.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (_) => true,
        ),
      );
      return responseHandler(response);
    } on DioError catch (_) {
      throw const FetchDataException(_connectionErrorMessage);
    }
  }

  void _handleResponse(Response<dynamic> response) {
    if (response.statusCode == 401 && response.data['error']['message']==("Invalid token")) {
      // Perform logout
      _showToast("Session expired. Please log in again.");
      _logout();
    }
  }

  void _logout() {
    // Clear user session data here
    // For example, using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    // Navigate to the login screen
    navigatorKey.currentState?.pushReplacementNamed(RouterConstants.loginWithPinRoute);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
