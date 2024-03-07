import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/enums/winch_status_types.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/winch_requests/status_label.dart';
class WinchRequestItem extends StatelessWidget {
  final WinchRequest winchRequest;
  final Function(WinchRequest) onPressed;

  const WinchRequestItem({Key key, this.winchRequest, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
          color: AColors.white,
          borderRadius: BorderRadius.circular(
            AStyling.getBorderRadius(context),
          ),
          border: Border.all(
              color: AColors.black,
              width: 1
          ),
          boxShadow: [
            BoxShadow(
                color: AColors.grey,
                blurRadius: 10,
                offset: Offset(0,5)
            )
          ]
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        onPressed: (){
          onPressed(winchRequest);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    winchRequest.userVehicle.category.name ?? _subtitle.noCategoryFound
                    + " " + winchRequest.userVehicle.year,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                ),
                WinchRequestStatusLabel(status: winchRequest.winchRequestStatus,)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    winchRequest.userVehicle.chassisNumber,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                ),
                Text(
                  DateFormat.yMd().add_jm().format(winchRequest.date),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
