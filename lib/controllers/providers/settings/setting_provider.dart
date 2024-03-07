import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winch/models/user.dart';

import '../settings/app_settings.dart';


class SettingProvider extends ChangeNotifier{

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  resetSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ASettings.user, null);
  }

  User _user = User();
  User get user => _user;
  Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(user == null){
      prefs.remove(ASettings.user);
    }else{
      prefs.setString(ASettings.user, json.encode(user.toJson()));
    }

    _user = user;
    notifyListeners();
  }

  String _language;
  String get language => _language;
  Future<void> setLanguage(String currentLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ASettings.language, currentLanguage);
    _language = currentLanguage;
    notifyListeners();
  }

  // call loadSharedPreferences when provider initialise
  SettingProvider(){
    loadSharedPreferences();
  }

  // get app setting
  Future<void> loadSharedPreferences() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey(ASettings.language)){
      _language = prefs.getString(ASettings.language);
    }else{
      _language  = 'en';
    }

    if(prefs.containsKey(ASettings.user)){
      String userJson = prefs.getString(ASettings.user);
      _user = User.fromSettingJson(json.decode(userJson));
      print(_user.toJson());
    }
    _isLoading = false;
    notifyListeners();
  }

}