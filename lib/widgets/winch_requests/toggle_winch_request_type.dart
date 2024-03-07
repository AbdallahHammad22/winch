import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
class ToggleWinchRequestType extends StatelessWidget {
  final int initialIndex;
  final Function(int) onTab;

  const ToggleWinchRequestType({Key key, this.initialIndex, this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return  DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Container(
        height: 38 * AStyling.getScaleFactor(context),
        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
        decoration: BoxDecoration(
            color: AColors.white,
            borderRadius: BorderRadius.circular(
                AStyling.borderRadius
            ),
            boxShadow: [
              AStyling.boxShadow
            ]
        ),
        child: TabBar(
          onTap: onTab,
          labelColor: AColors.black,
          unselectedLabelColor: AColors.grey,
          labelStyle: Theme.of(context).textTheme.subtitle1,
          indicator: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(
                  AStyling.borderRadius
              ),
              boxShadow: [
                AStyling.boxShadow
              ]
          ),
          tabs: [
            Tab(text: _subtitle.live),
            Tab(text: _subtitle.scheduled),
          ]
        ),
      ),
    );
  }
}
