import 'package:winch/models/coupon.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/user_vehicle.dart';

import 'enums/payment_methods_types.dart';

class Subscription{
  Package package;
  UserVehicle userVehicle;
  PaymentMethods paymentMethod;
  Coupon coupon;
  bool oneTimeRequest;
  String popTo;
  String referralCode;

  Subscription({
    this.package,
    this.userVehicle,
    this.paymentMethod,
    this.coupon,
    this.popTo,
    this.oneTimeRequest = false,
    this.referralCode,
  });

  toJson(){
    Map<String,String> jsonObject = {};
    if(userVehicle != null)
      jsonObject["user_id"] = userVehicle.userId.toString();
    if(userVehicle != null)
      jsonObject["user_vehicle_id"] = userVehicle.id.toString();
    if(package != null)
      jsonObject["package_id"] = package.id.toString();
    if(coupon != null)
      jsonObject["coupon_id"] = coupon.id;
    if(oneTimeRequest == true)
      jsonObject["type"] = "wynchRequest";
    else
      jsonObject["type"] = "package";

    if(paymentMethod != null)
      jsonObject["payment_method"] = paymentMethod.toString().split((".")).last;

    if(referralCode != null)
      jsonObject["use_referral"] = referralCode;

    return jsonObject;
  }
}