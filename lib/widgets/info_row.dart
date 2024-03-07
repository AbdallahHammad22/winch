import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class InfoRow extends StatelessWidget {
  final String title;
  final String info;
  final Widget infoAsWidget;
  final bool hideDivider;

  const InfoRow({Key key, this.title, this.info, this.infoAsWidget,this.hideDivider = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title + " : ",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),
                textScaleFactor: AStyling.getScaleFactor(context),
              ),
            ),
            infoAsWidget ?? Text(
              info,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14
              ),
              textScaleFactor: AStyling.getScaleFactor(context),
            ),
          ],
        ),
        Visibility(
            visible: !hideDivider,
            child: Divider()
        ),
      ],
    );
  }
}
