import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch/models/enums/winch_request_types.dart';
import 'package:winch/models/enums/winch_status_types.dart';
import 'package:winch/models/review.dart';
import 'package:winch/models/user_vehicle.dart';

import 'coupon.dart';
import 'enums/payment_methods_types.dart';

class WinchRequest{
  int id;
  String userId;
  LatLng startLocation;
  LatLng endLocation;
  DateTime date;
  UserVehicle userVehicle;
  WinchRequestType winchRequestType;
  WinchRequestStatus winchRequestStatus;
  List<WinchServiceReview> reviews;
  Coupon coupon;
  String price;
  String phone;
  String note;
  PaymentMethods paymentMethod;
  String referralCode;

  WinchRequest({
    this.id,
    this.userId,
    this.startLocation,
    this.endLocation,
    this.userVehicle,
    this.date,
    this.reviews,
    this.winchRequestStatus,
    this.winchRequestType = WinchRequestType.live,
    this.coupon,
    this.price,
    this.paymentMethod,
    this.referralCode,
    this.note,
    this.phone,
  });

  fromWinchRequest(WinchRequest newWinchRequest){
    id = newWinchRequest.id;
    userId = newWinchRequest.userId;
    startLocation = newWinchRequest.startLocation;
    endLocation = newWinchRequest.endLocation;
    userVehicle = newWinchRequest.userVehicle;
    date = newWinchRequest.date;
    reviews = newWinchRequest.reviews;
    winchRequestType = newWinchRequest.winchRequestType;
    winchRequestStatus = newWinchRequest.winchRequestStatus;
    coupon = newWinchRequest.coupon;
    paymentMethod = newWinchRequest.paymentMethod;
    referralCode = newWinchRequest.referralCode;
    note = newWinchRequest.note;
    phone = newWinchRequest.phone;
  }

  Map<String,dynamic> toJson(){
    return {
      "pickup_latitude": startLocation.latitude.toString(),
      "pickup_longitude": startLocation.longitude.toString(),
      "destination_latitude": endLocation.latitude.toString(),
      "destination_longitude": endLocation.longitude.toString(),
      "date": date.toString(),
      "type": winchRequestType.toString().split(".").last,
      "user_vehicle_id": userVehicle.id.toString(),
      "user_id": userId.toString(),
      "notes": note,
      "phoneNo": userId,
    };
  }

  toPayJson(){
    Map<String,String> jsonObject = {};
    if(userVehicle != null)
      jsonObject["user_id"] = userId.toString();
    if(userVehicle != null)
      jsonObject["request_id"] = id.toString();
    if(userVehicle != null)
      jsonObject["user_vehicle_id"] = userVehicle.id.toString();
    if(coupon != null)
      jsonObject["coupon_id"] = coupon.id;
    jsonObject["type"] = "wynchRequest";
    if(paymentMethod != null)
      jsonObject["payment_method"] = paymentMethod.toString().split((".")).last;
    if(referralCode != null)
      jsonObject["use_referral"] = referralCode;
    return jsonObject;
  }
  factory WinchRequest.fromJson(Map<String,dynamic> parsedJson){
    WinchRequestType requestType;
    if(parsedJson["type"] == "live"){
      requestType = WinchRequestType.live;
    }else{
      requestType = WinchRequestType.scheduled;
    }

    WinchRequestStatus requestStatus;
    if(parsedJson["status"] == "started"){
      requestStatus = WinchRequestStatus.started;
    }else if(parsedJson["status"] == "finished"){
      requestStatus = WinchRequestStatus.finished;
    }else{
      requestStatus = WinchRequestStatus.pending;
    }

    UserVehicle _userVehicle = UserVehicle.fromJson(parsedJson["userVehicle"]);
    List<WinchServiceReview> _reviews;
    if(parsedJson["review"] != null){
      List _reviewsList = parsedJson["review"];
      _reviews = _reviewsList.map(
              (review) => WinchServiceReview.fromJson(review)
      ).toList();
    }
    return WinchRequest(
      id: parsedJson["id"],
      startLocation: LatLng(
        double.tryParse(parsedJson["pickup_latitude"] ?? "0.0") ?? 0.0,
        double.tryParse(parsedJson["pickup_longitude"] ?? "0.0")?? 0.0
      ),
      endLocation: LatLng(
          double.tryParse(parsedJson["destination_latitude"] ?? "0.0") ?? 0.0,
          double.tryParse(parsedJson["destination_longitude"] ?? "0.0")?? 0.0
      ),
      date: DateTime.tryParse(parsedJson["date"]),
      winchRequestStatus: requestStatus,
      winchRequestType: requestType,
      userId:  parsedJson["user_id"].toString(),
      price:  parsedJson["price"].toString(),
      userVehicle: _userVehicle,
      reviews: _reviews,
      phone: parsedJson["phoneNo"],
      note: parsedJson["notes"],
    );
  }
}