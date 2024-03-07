import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/models/review.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/winch_request.dart';

class WinchRequestsProvider extends ChangeNotifier{

  // number of items call in each request
  final pageItemNumber = 20;

  //reset provider data
  void reset(){
    winchRequests = null;
    nextPage = true;
    stateCode = null;
  }

  // state code of current request to defied error message
  // like 400 customer request failed
  // 500 service not available
  int stateCode;

  // true if winch requests list page is loaded and false if not
  bool isLoading;

  // true if there is next page in winch requests list and false if not
  bool nextPage = true;

  // contain winch requests list
  List<WinchRequest> winchRequests;

  Future<int> getWinchRequests(
      {
        @required String userId,
        @required String token,
        @required String language
      }) async {
    print("start load <----");
    if(isLoading == true)
      return -2;
    isLoading = true;
    notifyListeners();
    http.Response response;
    try{
      response = await http.get(
        Uri.tryParse(URLs.getWinchRequests
            + '?page=${(winchRequests?.length ?? 0)/pageItemNumber}'
            '&user_id=$userId'),
        headers: {
          "Authorization":"Bearer $token",
          "language": language,
          "Accept": "application/json",
        }
      );
    } catch(_) {
      print(_);
      isLoading = false;
      stateCode = -1;
      notifyListeners();
      return -1;
    }

    // If the call to the server was successful, parse the JSON.
    if (response.statusCode >= 200 && response.statusCode < 300){
      // If the call to the server was successful, parse the JSON.
      print("200 <----");
      Map<String,dynamic> responseAsMap = jsonDecode(response.body);
      List jsonList = responseAsMap["data"];
      List<WinchRequest> _winchRequestsPage = jsonList.map((i) => WinchRequest.fromJson(i)).toList();
      if(winchRequests == null)
        winchRequests = [];
      winchRequests.addAll(_winchRequestsPage);
      // todo change condition after ahmed update request
      if(_winchRequestsPage.length == pageItemNumber){
        nextPage = true;
      }else{
        nextPage = false;
      }
    }
    isLoading = false;
    stateCode = response.statusCode;
    notifyListeners();
    return response.statusCode;
  }

  Future<WinchRequest> getSingleWinchRequest({
    @required String requestId,
    @required String token,
    @required String language,
    @required Subtitle subtitle,
  }) async {
    print("start load <----");

    http.Response response;
    try{
      response = await http.get(
          Uri.tryParse(URLs.getSingleWinchRequest+"/$requestId"),
          headers: {
            "Authorization":"Bearer $token",
            "language": language,
            "Accept": "application/json",
          }
      );
    }catch(error){
      print(error);
      throw(HttpStatusManger.getStatusMessage(
          status: -1, subtitle: subtitle));
    }

    print(response.body);
    // If the call to the server was successful, parse the JSON.
    if (response.statusCode >= 200 && response.statusCode < 300){
      // If the call to the server was successful, parse the JSON.
      print("200 <----");
      return WinchRequest.fromJson(jsonDecode(response.body)["data"]);
    }else{
      throw(HttpStatusManger.getStatusMessage(
          status: response.statusCode, subtitle: subtitle));
    }

  }

  Future<int> createWinchRequest({
    @required WinchRequest winchRequest,
    @required String userId,
    @required String token,
    @required String language
  }) async {
    http.Response response;
    try{
      response = await http.post(
          Uri.tryParse(URLs.createWinchRequest),
          body: winchRequest.toJson(),
          headers: {
            "Authorization":"Bearer $token",
            "language": language,
            "Accept": "application/json",
          }
      );
    } catch(error) {
      print(error);
      return -1;
    }
    print(response.body);
    // If the call to the server was successful, parse the JSON.
    if (response.statusCode >= 200 && response.statusCode < 300){
      // If the call to the server was successful, parse the JSON.
      WinchRequest _winchRequest = WinchRequest.fromJson(jsonDecode(response.body)["data"]);
      if(winchRequests == null)
        winchRequests = [];
      winchRequests.insert(0,_winchRequest);
      notifyListeners();
    }
    return response.statusCode;
  }

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<WinchServiceReview> reviewWinchService ({
    @required String token,
    @required String language,
    WinchServiceReview winchServiceReview,
    Subtitle subtitle,
  }) async {

    http.Response response;
    try{
      print(winchServiceReview.toJson());
      response = await http.post(
          Uri.tryParse(URLs.reviewWinchServiceRequest),
          headers: {
            "Authorization":"Bearer $token",
            "language": language,
            "Accept": "application/json",
          },
          body: winchServiceReview.toJson()
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
      WinchServiceReview _review = WinchServiceReview.fromJson(jsonDecode(response.body)["data"]);
      return _review;
    }else{
      throw(HttpStatusManger.getStatusMessage(
          status: response.statusCode, subtitle: subtitle));
    }
  }
}