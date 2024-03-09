import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/models/about_data.dart';
import 'package:winch/models/category.dart';
import 'package:winch/views/user/contact_us.dart';

class TermsAndConditionsProvider extends ChangeNotifier{

  //reset provider data
  void reset(){
    termsAndConditions = null;
    stateCode = null;
  }

  // state code of current request to defied error message
  // like 400 customer request failed
  // 500 service not available
  int stateCode;

  // contain about us data
  String termsAndConditions;

  // when about us in-process _loading = true
  // done _loading = true
  // failed _loading = false
  bool isLoading = false;

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> getTermsAndConditions ({
    @required String token,
    @required String language
  }) async {
    if(isLoading == true)
      return -2;
    isLoading = true;
    Response response;
    print("start loading");
    try{
      response = await get(
          Uri.tryParse(URLs.getTermsAndConditions),
        headers: {
          "Authorization":"Bearer $token",
          "language": language,
          "Accept": "application/json",
        }
      );
    } catch(error) {
      print(error);
      isLoading = false;
      stateCode = -1;
      notifyListeners();
      return -1;
    }
    print("end loading");
    stateCode = response.statusCode;
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      termsAndConditions = jsonDecode(response.body)["data"];
    }
    isLoading = false;
    notifyListeners();
    return response.statusCode;
  }
}