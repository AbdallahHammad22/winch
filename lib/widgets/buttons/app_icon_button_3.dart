import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AIconButton3 extends StatelessWidget {

  final IconData iconData;
  final Color backgroundColor;
  final iconSize;
  final VoidCallback onPressed;

  const AIconButton3({
    Key key,
    this.iconData,
    this.iconSize,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipOval(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          padding: EdgeInsets.zero,
          color: Theme.of(context).scaffoldBackgroundColor,
          iconSize: iconSize ?? 32,
          icon: Ink(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor ?? AColors.white,
              shape: BoxShape.circle
            ),
            child: FaIcon(iconData,color: AColors.black,size: iconSize,)
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
