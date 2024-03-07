import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/subtitle.dart';
class CouponSummary extends StatelessWidget {
  final double packagePrice;
  final Coupon coupon;

  const CouponSummary({Key key, this.packagePrice, this.coupon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    print(packagePrice);
    print(coupon.toJson());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: RaisedButton(
          splashColor: Theme.of(context).accentColor,
          elevation: 8,
          padding: EdgeInsets.symmetric(vertical: 4),
          color: AColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                AStyling.getBorderRadius(context)
            ),
            side: BorderSide(
                color: AColors.yellow,
                width: 2,
                style: BorderStyle.solid
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                child: Text(
                  coupon.code ?? "no coupon found",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize: 14
                  ),
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ),
              Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Package Price: ",
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                            textScaleFactor: AStyling.getScaleFactor(context),
                          ),
                        ),
                        Text(
                          "$packagePrice ${_subtitle.egp}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12
                          ),
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Coupon Discount: ",
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                            textScaleFactor: AStyling.getScaleFactor(context),
                          ),
                        ),
                        Text(
                          "${coupon.getDiscount(packagePrice)} ${_subtitle.egp}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12
                          ),
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(thickness: 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child:  Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total Price: ",
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                            textScaleFactor: AStyling.getScaleFactor(context),
                          ),
                        ),
                        Text(
                          "${packagePrice - coupon.getDiscount(packagePrice)} ${_subtitle.egp}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12
                          ),
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ],
          ),
          onPressed: (){

          }
      ),
    );
  }
}
