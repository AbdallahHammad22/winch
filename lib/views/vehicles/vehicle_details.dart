import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/views/subscription/make_subscription.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/image_loader.dart';
import 'package:winch/widgets/packages/package_item.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/user_vehicles/vehicle_info_row.dart';
class VehicleDetails extends StatefulWidget {
  final UserVehicle userVehicle;

  const VehicleDetails({Key key, this.userVehicle}) : super(key: key);
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title:  Image(
          image: AssetImage("assets/images/logo_horizontal.png"),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 32),
          children: [
            SizedBox(height: 8,),
            ASubTitle(_subtitle.brand),
            VehicleInfoRow(text: widget.userVehicle.category.name ?? _subtitle.noCategoryFound,),

            SizedBox(height: 8,),
            ASubTitle(_subtitle.chassisNumber),
            VehicleInfoRow(text: widget.userVehicle.chassisNumber ?? _subtitle.noChassisNumberFound,),

            SizedBox(height: 8,),
            ASubTitle(_subtitle.year),
            VehicleInfoRow(text: widget.userVehicle.year ?? _subtitle.noYearFound,),

            SizedBox(height: 8,),
            ASubTitle(_subtitle.status),
            VehicleInfoRow(text: _subtitle.getVehicleStatus(widget.userVehicle.status)),

            SizedBox(height: 8,),
            ASubTitle(_subtitle.frontCarLicence),
            SizedBox(height: 4,),
            SizedBox(
              height: 100 * AStyling.getScaleFactor(context),
              child: ImageLoader(url: widget.userVehicle.frontCarLicence,boxFit: BoxFit.contain,)
            ),

            SizedBox(height: 8,),
            ASubTitle(_subtitle.backCarLicence),
            SizedBox(height: 4,),
            SizedBox(
                height: 100 * AStyling.getScaleFactor(context),
                child: ImageLoader(url: widget.userVehicle.backCarLicence,boxFit: BoxFit.contain,)
            ),

            widget.userVehicle.package != null ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                ASubTitle(_subtitle.package),
                AbsorbPointer(
                  child: PackageItem(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    package: widget.userVehicle.package,
                  ),
                ),
              ],
            ): SizedBox.shrink(),

            SizedBox(height:  32,),
            SizedBox(
              width: MediaQuery.of(context).size.width /1.3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AButton(
                  text: _subtitle.subscribe,
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_)=> MakeSubscription(
                              subscription: Subscription(
                                  userVehicle: widget.userVehicle,
                                  package: widget.userVehicle?.package
                              ),
                            )
                        )
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
