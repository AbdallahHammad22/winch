import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AIconButton2 extends StatelessWidget {

  final IconData iconData;
  final iconSize;
  final VoidCallback onPressed;

  const AIconButton2({
    Key key, this.iconData, this.iconSize, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      padding: EdgeInsets.zero,

      color: Theme.of(context).scaffoldBackgroundColor,
      icon: FaIcon(iconData,color: AColors.yellow,size: iconSize,),
      onPressed: onPressed,
    );
  }
}
