import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:winch/controllers/api_routes/urls.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';

class UserVehiclesProvider extends ChangeNotifier{

  //reset provider data
  void reset(){
    userVehicles = null;
    stateCode = null;
  }

  // state code of current request to defied error message
  // like 400 customer request failed
  // 500 service not available
  int stateCode;

  // contain user data
  // when user not login or register _user = null
  List<UserVehicle> userVehicles;

  // when categories in-process _loading = true
  // done _loading = true
  // failed _loading = false
  bool isLoading;

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> getUserVehicles ({
    @required String token,
    @required String userId,
    @required String language
  }) async {
    if(isLoading == true)
      return -2;
    isLoading = true;
    notifyListeners();
    Response response;
    try{
      response = await get(
        Uri.tryParse(URLs.getUserVehicles+"/$userId"),
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
        List vehiclesListJson = jsonDecode(response.body)["data"];
        userVehicles = vehiclesListJson.map((userVehicle) => UserVehicle.fromJson(userVehicle)).toList();
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

  Future<UserVehicle> getSingleUserVehicle({
    @required String userVehicleId,
    @required String token,
    @required String language,
    @required Subtitle subtitle,
  }) async {
    print("start load <----");

    Response response;
    try{
      response = await get(
          Uri.tryParse(URLs.getSingleUserVehicles+"/$userVehicleId"),
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
      return UserVehicle.fromJson(jsonDecode(response.body)["data"]);
    }else{
      throw(HttpStatusManger.getStatusMessage(
          status: response.statusCode, subtitle: subtitle));
    }
  }

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> addUserVehicle ({
    @required String token,
    @required UserVehicle userVehicle,
    @required String language
  }) async {
    MultipartRequest request = new MultipartRequest("POST",  Uri.parse(URLs.addUserVehicles));
    request.headers["Authorization"] = "Bearer $token";
    request.headers["language"] = language;
    request.headers["Accept"] = "application/json";
    request.fields["user_id"] = userVehicle.userId.toString();
    request.fields["category_id"] = userVehicle.category.id.toString();
    request.fields["chassis_number"] = userVehicle.chassisNumber;
    request.fields["year"] = userVehicle.year;
    request.files.add(await MultipartFile.fromPath(
      "front_car_licence",
      userVehicle.frontCarLicence,
      filename: userVehicle.frontCarLicence.split("/").last,
    ));
    request.files.add(await MultipartFile.fromPath(
      'back_car_licence',
      userVehicle.backCarLicence,
      filename: userVehicle.backCarLicence.split("/").last,
    ));

    Response response;
    try{
      response = await Response.fromStream(await request.send());
      print(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        // client's request was successfully received
        if(userVehicles == null){
          userVehicles = [];
          stateCode = 200;
          isLoading = false;
        }

        userVehicles.insert(
            0,
            UserVehicle.fromJson(jsonDecode(response.body)["data"])
        );
        notifyListeners();
      }
      return response.statusCode;
    } catch(error) {
      print(error);
      return -1;
    }


  }

  /// return -2 if request in progress
  /// return -1 if error happen when sending request
  /// return state code if request complete may be 200, 404 or 403
  /// for more details check http state manager
  /// lib\controllers\http_status_manger\http_status_manger.dart
  Future<int> updateUserVehicle ({
    @required String token,
    @required UserVehicle newUserVehicle,
    @required UserVehicle userVehicle,
    @required String language
  }) async {
    MultipartRequest request = new MultipartRequest(
        "POST",
        Uri.parse(URLs.updateUserVehicles+"/${newUserVehicle.id}")
    );
    request.headers["Authorization"] = "Bearer $token";
    request.headers["language"] = language;
    request.headers["Accept"] = "application/json";
    request.fields["user_id"] = newUserVehicle.userId.toString();
    request.fields["user_vehicle_id"] = newUserVehicle.id.toString();
    request.fields["category_id"] = newUserVehicle.category.id.toString();
    request.fields["chassis_number"] = newUserVehicle.chassisNumber;
    request.fields["year"] = newUserVehicle.year;
    if(newUserVehicle.frontCarLicence != null){
      request.files.add(await MultipartFile.fromPath(
        "front_car_licence",
        newUserVehicle.frontCarLicence,
        filename: newUserVehicle.frontCarLicence.split("/").last,
      ));
    }

    if(newUserVehicle.backCarLicence != null){
      request.files.add(await MultipartFile.fromPath(
        'back_car_licence',
        newUserVehicle.backCarLicence,
        filename: newUserVehicle.backCarLicence.split("/").last,
      ));
    }

    print(request.fields);

    Response response;
    try{
      response = await Response.fromStream(await request.send());
      print(response.body);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        // client's request was successfully received
        UserVehicle _userVehicle = UserVehicle.fromJson(jsonDecode(response.body)["data"]);
        userVehicle.fromUserVehicle(_userVehicle);
        notifyListeners();
      }
      return response.statusCode;
    } catch(error) {
      print(error);
      return -1;
    }
  }

  bool checkIfSubscribe(){
    if(userVehicles == null)
      return null;

    bool _hasPackage = false;
    userVehicles.forEach((car) {
      if(car?.expiryDate != null){
        if(car.expiryDate.isAfter(DateTime.now()))
          _hasPackage = true;
          return;
      }
    });

    return _hasPackage;
  }
}