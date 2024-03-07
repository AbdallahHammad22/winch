import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/widgets/info_row.dart';
class VehicleSummery extends StatelessWidget {
  final UserVehicle userVehicle;

  const VehicleSummery({Key key, this.userVehicle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
      ),
      decoration: BoxDecoration(
          color: AColors.lightGrey,
          boxShadow: [
            BoxShadow(
                color: AColors.grey,
                blurRadius: 10,
                offset: Offset(0,5)
            )
          ]
      ),
      child: Column(
        children: [
          InfoRow(
            title: _subtitle.category,
            info: userVehicle.category.name ?? _subtitle.noCategoryFound,
          ),
          InfoRow(
            title: _subtitle.year,
            info: userVehicle.year ?? _subtitle.noYearFound,
          ),
          InfoRow(
            title: _subtitle.chassisNumber,
            info: userVehicle.chassisNumber ?? _subtitle.noChassisNumberFound,
          ),
        ],
      ),
    );
  }
}
