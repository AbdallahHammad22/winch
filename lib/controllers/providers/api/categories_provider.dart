import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/models/category.dart';

class CategoriesProvider extends ChangeNotifier{

  //reset provider data
  void reset(){
    _categories = null;
    _stateCode = null;
  }

  // state code of current request to defied error message
  // like 400 customer request failed
  // 500 service not available
  int _stateCode;
  int get stateCode => _stateCode;

  // contain user data
  // when user not login or register _user = null
  List<Category> _categories;
  List<Category> get categories => _categories;

  // when categories in-process _loading = true
  // done _loading = true
  // failed _loading = false
  bool _loading;
  bool get isLoading => _loading;
  set isLoading(bool isLoading){
    _loading = isLoading;
    notifyListeners();
  }

  /// sign in with user - need (email or phone) and password;
  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> getCategories ({
    @required String token,
    @required String language
  }) async {
    if(_loading == true)
      return -2;
    _loading = true;
    notifyListeners();
    Response response;
    print("start loading");
    try{
      response = await get(
        Uri.tryParse(URLs.getCategories),
        headers: {
          "Authorization":"Bearer $token",
          "language": language,
          "Accept": "application/json",
        }
      );
    } catch(error) {
      print(error);
      _loading = false;
      _stateCode = -1;
      notifyListeners();
      return -1;
    }
    print("end loading");
    _stateCode = response.statusCode;
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      List categoriesListJson = jsonDecode(response.body)["data"];
      _categories = categoriesListJson.map((category) => Category.fromJson(category)).toList();
    }
    _loading = false;
    notifyListeners();
    return response.statusCode;
  }
}