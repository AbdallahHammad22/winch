import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/models/error.dart';
import 'package:winch/models/user.dart';

class UserProvider extends ChangeNotifier{

  //reset provider data
  void reset(){
    userDate = null;
    isLoading = false;
    error = null;
  }

  // contain user data
  // when user not login or register _user = null
  User userDate;

  // when login or register in-process _login = true
  // when login or register is done or not start = false
  bool isLoading = false;

  AError error;

  /// sign in with user - need (email or phone) and password;
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  Future<int> login ({
    @required User user,
    @required String language
  }) async {
    isLoading = true;
    error = AError();
    notifyListeners();

    http.Response response;
    try{
      user.fireBaseToken = await FirebaseMessaging.instance.getToken();
      response = await http.post(
          Uri.tryParse(URLs.login),
         body: user.toLoginJson(),
          headers: {
            "language": language,
            "Accept": "application/json",
          }
      );
    }catch(error){
      print(error);
      isLoading = false;
      notifyListeners();
      return -1;
    }
    print(response.body);
    print(response.statusCode);
    isLoading = false;
    notifyListeners();
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      userDate = User.fromJson(json.decode(response.body));
      notifyListeners();
    }
    return response.statusCode;
  }

  /// sign up with user object;
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  Future<int> register ({
    @required User user,
    @required String language,

  }) async {
    isLoading = true;
    error = AError();
    notifyListeners();
   // Map<String,dynamic> body;
   // body = user.toRegisterJson();
   // if(user.image != null) body["image"] = await MultipartFile.fromFile(user.image,filename: user.image.split("/").last);
   // FormData formData = new FormData.fromMap(body);
    http.Response response;
    try{
      user.fireBaseToken = await FirebaseMessaging.instance.getToken();
      response = await http.post(
          Uri.tryParse(URLs.register),
          body: user.toRegisterJson(),
          headers: {
            "language": language,
            "Accept": "application/json",
          }
      );
    } catch(error){
      print(error);
      isLoading = false;
      notifyListeners();
      return -1;
    }
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      userDate = User.fromJson(json.decode(response.body));
    }else if(response.statusCode >= 400 && response.statusCode < 500){
      error = AError.fromJson(json.decode(response.body)["errors"]);
    }
    isLoading = false;
    notifyListeners();
    return response.statusCode;
  }

  /// send sms message to user to verification;
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> sendCode (String phone) async {
    http.Response response;
    try{
      response = await http.post(
          Uri.tryParse(URLs.sendCodeToPhoneNumber),
        body: {"phone":phone},
        headers: {
          "Accept": "application/json",
        }
      );
    } catch(error) {
      print(error);
      return -1;
    }
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
    }
    return response.statusCode;
  }

  /// send sms message to user to verification;
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> verifyPhone ({
    @required String phone, @required String code}) async {
    http.Response response;
    print(userDate.toLoginJson());
    try{
      response = await http.post(
          Uri.tryParse(URLs.verifyPhoneNumber),
        body: {
          "phone":userDate.phoneNumber,
          "code":code
        },
          headers: {
            "Accept": "application/json",
          }
      );
    } catch(error) {
      print(error);
      return -1;
    }
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
    }
    return response.statusCode;
  }

  /// reset user password;
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> resetPassword ({
    @required String phone,
    @required String code,
    @required String password}) async {
    http.Response response;
    print("$phone - $code - $password");
    try{
      response = await http.post(
          Uri.tryParse(URLs.forgetPassword),
        body: {
          "phone":phone,
          "code":code,
          "password":password,
          "password_confirmation":password,
        },
          headers: {
            "Accept": "application/json",
          }
      );
    } catch(error) {
      print(error);
      return -1;
    }
    print(response.body);
    print(response.headers);
    print(response.statusCode);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
    }
    return response.statusCode;
  }
}