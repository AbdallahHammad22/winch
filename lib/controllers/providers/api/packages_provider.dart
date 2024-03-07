import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/winch_request.dart';

class PackagesProvider extends ChangeNotifier{

  //reset provider data
  void reset(){
    packages = null;
    stateCode = null;
  }

  // state code of current request to defied error message
  // like 400 customer request failed
  // 500 service not available
  int stateCode;

  List<Package> packages;

  // when categories in-process _loading = true
  // done _loading = true
  // failed _loading = false
  bool isLoading;


  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> getPackages ({
    @required String token,
    @required String language
  }) async {
    if(isLoading == true)
      return -2;
    isLoading = true;
    notifyListeners();
    Response response;
    try{
      response = await get(
          Uri.tryParse(URLs.getPackages),
        headers: {
          "Authorization":"Bearer $token",
          "language": language,
          "Accept": "application/json",
        }
      );
      stateCode = response.statusCode;
      print(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        // client's request was successfully received
        List listJson = jsonDecode(response.body)["data"];
        packages = listJson.map((package) => Package.fromJson(package)).toList();
      }
      isLoading = false;
      notifyListeners();
      return response.statusCode;

    } catch(error) {
      print(error);
      isLoading = false;
      stateCode = -1;
      notifyListeners();
      return -1;
    }
  }

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<String> getPaymentUrl ({
    @required String token,
    @required String language,
    Subscription subscription,
    WinchRequest winchRequest,
    Subtitle subtitle,
  }) async {

    Response response;
//    print(subscription?.toJson());
  //  print(winchRequest?.toPayJson());
    try{
      response = await post(
          Uri.tryParse(URLs.getPaymentUrl),
        headers: {
          "Authorization":"Bearer $token",
          "language": language,
          "Accept": "application/json",
        },
        body: subscription == null
            ? winchRequest.toPayJson()
            : subscription.toJson()
      );
    } catch(error){
      print(error);
      throw(HttpStatusManger.getStatusMessage(
          status: -1, subtitle: subtitle));
    }
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      //List listJson = jsonDecode(response.body)["data"];
      String url = jsonDecode(response.body)["data"]["url"];
      print(url);
      return url;
    }else{
      if(response.statusCode == 400)
        throw( jsonDecode(response.body)["message"]);

      throw(HttpStatusManger.getStatusMessage(
          status: response.statusCode, subtitle: subtitle));
    }
  }

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<Coupon> getCoupon ({
    @required String token,
    @required String language,
    Coupon coupon,
    Subtitle subtitle,
  }) async {

    Response response;
    try{
      response = await post(
          Uri.tryParse(URLs.getCoupon),
          headers: {
            "Authorization":"Bearer $token",
            "language": language,
            "Accept": "application/json",
          },
          body: coupon.toJson()
      );

    } catch(error) {
      print(error);
      throw(HttpStatusManger.getStatusMessage(
          status: -1, subtitle: subtitle));
    }
    print(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      // client's request was successfully received
      //List listJson = jsonDecode(response.body)["data"];
      Coupon _coupon = Coupon.fromJson(jsonDecode(response.body)["data"]);
      return _coupon;
    }else{
      throw(HttpStatusManger.getStatusMessage(
          status: response.statusCode,
          subtitle: subtitle,
          messageFor400: subtitle.inValidCoupon
      ));
    }
  }
}