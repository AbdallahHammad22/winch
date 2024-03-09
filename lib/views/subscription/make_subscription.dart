import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/views/subscription/get_coupon.dart';
import 'package:winch/views/subscription/payment_method.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/coupons/coupon_summary.dart';
import 'package:winch/widgets/from_top_cover.dart';
import 'package:winch/widgets/packages/package_item.dart';
import 'package:winch/widgets/packages/package_picker.dart';
import 'package:winch/widgets/titles/app_title.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
class MakeSubscription extends StatefulWidget {
  static final String id = "make-subscription";
  final Subscription subscription;
  const MakeSubscription({Key key, this.subscription}) : super(key: key);
  @override
  _MakeSubscriptionState createState() => _MakeSubscriptionState();
}

class _MakeSubscriptionState extends State<MakeSubscription>
    with TickerProviderStateMixin {
  Subtitle _subtitle;
  Subscription _subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = widget.subscription;
  }
  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      body: ListView(
        children: [
          FormTopCover(_subtitle.pickCarAndPackage),
          ATitle(_subtitle.package),
          SizedBox(height: 4,),
          PackageItem(
            package: _subscription.package,
            onPressed: (package) async {
              Package _package = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_)=> PackagePicker()
                  )
              ) as Package;
              if(_package != null){
                _subscription.package = _package;
                setState(() {});
              }
            },
          ),
          ATitle(_subtitle.car),
          SizedBox(height: 4,),
          SizedBox(
            height: 100 * AStyling.getScaleFactor(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: UserVehiclesItem(
                userVehicle: _subscription.userVehicle,
                selectedUserVehicle: UserVehicle(),
                onPressed: (vehicles) async {
                  UserVehicle _userVehicle = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_)=> UserVehiclesPicker()
                      )
                  ) as UserVehicle;
                  if(_userVehicle != null){
                    _subscription.userVehicle = _userVehicle;
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          ATitle(_subtitle.coupon),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: AButton(
              text: _subscription.coupon?.title ??_subtitle.addCoupon,
              onPressed: () async {
                _subscription.coupon = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_)=> GetCoupon()
                    )
                ) as Coupon;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 32,),
          Center(
            child: AnimatedSize(
              duration: Duration(milliseconds: 400),
              vsync: this,
              curve: Curves.easeInOut,
              child: Visibility(
                visible: _subscription.package != null
                && _subscription.userVehicle != null,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width /1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AButton(
                      text: _subtitle.next,
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_)=> PaymentMethod(
                                  subscription: _subscription,
                                )
                            )
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
