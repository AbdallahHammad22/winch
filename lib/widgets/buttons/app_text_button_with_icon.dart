import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
  class ATextButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData iconData;
  final iconSize;
  final VoidCallback onPressed;

  const ATextButtonWithIcon({Key key, this.text, this.onPressed,this.iconData, this.iconSize = 24.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: SizedBox(
          width:28*AStyling.getScaleFactor(context),
          child: FaIcon(iconData,color: AColors.yellow,size: iconSize,)),
      label: Expanded(
        child: Text(
          text??"",
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: AStyling.getScaleFactor(context),
        ),
      ),
      onPressed: onPressed
    );
  }
}
