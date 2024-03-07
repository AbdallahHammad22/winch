import 'package:winch/models/brand.dart';
import 'package:winch/models/enums/vehicle_status_types.dart';
import 'package:winch/models/package.dart';

import 'category.dart';
import 'vehicle.dart';

class UserVehicle{
  int id;
  String userId;
  Category category;
  VehicleStatus status;
  String frontCarLicence;
  String backCarLicence;
  String chassisNumber;
  String year;
  Package package;
  DateTime startDate;
  DateTime expiryDate;

  UserVehicle({
    this.id,
    this.userId,
    this.category,
    this.frontCarLicence,
    this.backCarLicence,
    this.chassisNumber,
    this.status,
    this.year,
    this.package,
    this.startDate,
    this.expiryDate,
  });

  fromUserVehicle(UserVehicle newVehicle){
    id = newVehicle.id;
    userId = newVehicle.userId;
    frontCarLicence = newVehicle.frontCarLicence;
    backCarLicence = newVehicle.backCarLicence;
    chassisNumber = newVehicle.chassisNumber;
    status = newVehicle.status;
    year = newVehicle.year;
    package = newVehicle.package;
    startDate = newVehicle.startDate;
    expiryDate = newVehicle.expiryDate;
  }

  factory UserVehicle.fromJson(Map<String,dynamic> parsedJson){
    Category _category = Category.fromJson(parsedJson["category"]);
    VehicleStatus vehicleStatus;
    if(parsedJson["status"] == "approved"){
      vehicleStatus = VehicleStatus.approved;
    }else if(parsedJson["status"] == "in-review"){
      vehicleStatus = VehicleStatus.in_review;
    }else{
      vehicleStatus = VehicleStatus.rejected;
    }
    Package _package;
    if(parsedJson["package"] != null){
      _package = Package.fromJson(parsedJson["package"]);
      _package.startDate =  DateTime.tryParse(parsedJson["subscriped_at"] ?? "");
      _package.expiryDate =  DateTime.tryParse(parsedJson["subscripe_ends_at"] ?? "");
    }
    return UserVehicle(
      id: parsedJson["id"],
      userId: parsedJson["user_id"].toString(),
      //plateNumber: parsedJson["plate_number"],
      //brand: brand,
      category: _category,
      chassisNumber: parsedJson["chassis_number"],
      //motorNumber: parsedJson["motor_number"],
      status: vehicleStatus,
      year: parsedJson["year"].toString(),
      backCarLicence: parsedJson["back_car_licence"],
      frontCarLicence: parsedJson["front_car_licence"],
      package: _package,
      startDate: _package?.startDate,
      expiryDate: _package?.expiryDate,
    );
  }
}