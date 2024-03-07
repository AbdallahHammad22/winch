import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class VehicleInfoRow extends StatelessWidget {
  final String text;

  const VehicleInfoRow({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: FontWeight.normal),
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
    );

  }
}
