import 'package:flutter/material.dart';
import 'package:nationremit/constants/constants.dart';
import 'package:nationremit/model/Get_signup_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nationremit/login/repository/login_repository.dart';
import 'package:nationremit/model/profile_details_model.dart';
import 'package:nationremit/model/register_model.dart';

import '../model/get_forgot_status.dart';
import '../model/get_remitter_ui_settings_model.dart';

class LoginProvider with ChangeNotifier {
  final _loginRepository = LoginRepository();

  RegisterModel? _userInfo; 
  var _isLoading = false;


  get isLoading => _isLoading;

  RegisterModel? get userInfo => _userInfo;



  void setLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> _saveIntoLocalPref(String? token) async {
    if(token == null){
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token ?? '');

  }
  Future<void> _saveNameIntoLocalPref(String? userName) async {
    if(userName == null){
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName ?? '');

  }

  Future<void> _saveEmailIntoLocalPref(String? email) async {
    if(email == null){
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', email ?? '');

  }


  Future<void> _setIsLoggedIn(bool isLoggedIn) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);

  }
  Future<bool?> _getIsLoggedIn() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn= prefs.getBool('isLoggedIn');
    return isLoggedIn;
  }

  Future<String> getUserName() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name= prefs.getString('userName');
    return name ?? '';
  }
  Future<String> getUserProfileImg() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name= prefs.getString(Constants.ProfileImage);
    return name ?? '';
  }
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  Future<RegisterModel> createUser({
    required String password,
    required String username,
    required String email,
    required String mobileNo,
    required String sourceCountry,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.userRegisterAPI(
      password: password,
      username: username,
      email: email,
      mobileNo: mobileNo,
      sourceCountry: sourceCountry,
    );
    try {
      _userInfo = res;
      _saveIntoLocalPref(res.response?.token);
      _saveNameIntoLocalPref(res.response?.userDetails?.firstName);
      _saveEmailIntoLocalPref(res.response?.userDetails?.email);
    }catch(e){

    }
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.verifyOTP(email: email, otp: otp);
    _userInfo = res;
    _saveIntoLocalPref(res.response?.token);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> loginAPI({
    required String email,
    required String password,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.userLoginAPI(
        email: email, password: password);
    _userInfo = res;
    _saveIntoLocalPref(res.response?.token);
    _saveEmailIntoLocalPref(res.response?.userDetails?.email);
    _saveNameIntoLocalPref(res.response?.userDetails?.firstName);
    setLoadingStatus(false);
    if(res.success!)
    _setIsLoggedIn(true);
    return res;
  }
  Future<RegisterModel> userLoginWithPinAPI({
    required String email,
    required String pin,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.userLoginWithPinAPI(
        email: email, pin: pin);
    _userInfo = res;
    _saveIntoLocalPref(res.response?.token);
    _saveEmailIntoLocalPref(res.response?.userDetails?.email);
    _saveNameIntoLocalPref(res.response?.userDetails?.firstName);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> forgotPasswordAPI({
    required String email,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.forgotPasswordAPI(
      email: email,
    );
    _saveIntoLocalPref(res.response?.token);
    setLoadingStatus(false);
    return res;
  }

  Future<RegisterModel> forgotVerifyOTPAPI({
    required String email,
    required String otp,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.forgotVerifyOTP(email: email, otp: otp);
    _userInfo = res;
    _saveIntoLocalPref(res.response?.token);
    setLoadingStatus(false);
    return res;
  }

  Future<void> resetPasswordAPI({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.newPasswordAPI(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    setLoadingStatus(false);
    return res;
  }

  Future<GetSignupStatus> getSignUpStatus({
    required String email
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.getSignUpStatus(
      email: email

    );
    setLoadingStatus(false);
    return res;
  }

  Future<GetForgotStatus> getForgotPasswordStatus({
    required String email
  }) async {
    setLoadingStatus(true);
    final res = await _loginRepository.getForgotPasswordStatus(
      email: email);
    _saveIntoLocalPref(res.token);
    setLoadingStatus(false);
    return res;
  }

  Future<GetRemitterUiSettingsModel> getRemitterUISettings() async {
    setLoadingStatus(true);
    try {
      final res = await _loginRepository.getRemitterUISettings();
      setLoadingStatus(false);
      return res;
    } finally {
      setLoadingStatus(false);
    }
  }
}
