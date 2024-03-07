import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/enums/winch_status_types.dart';
import 'package:winch/models/subtitle.dart';
class WinchRequestStatusLabel extends StatelessWidget {
  final WinchRequestStatus status;

  const WinchRequestStatusLabel({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 2),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(
            AStyling.getBorderRadius(context),
          ),
          boxShadow: [
            BoxShadow(
                color: AColors.grey,
                blurRadius: 10,
                offset: Offset(0,5)
            )
          ]
      ),
      child: Text(
        _subtitle.getRequestStatus(status),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 14
        ),
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
    );
  }
}
