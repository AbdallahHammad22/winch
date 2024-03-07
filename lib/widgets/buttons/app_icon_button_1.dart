import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AIconButton1 extends StatelessWidget {

  final IconData iconData;
  final iconSize;
  final VoidCallback onPressed;

  const AIconButton1({
    Key key, this.iconData, this.iconSize, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 36 * AStyling.getScaleFactor(context),
      width: 36 * AStyling.getScaleFactor(context),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AColors.yellow,
              width: 2
            ),
            borderRadius: BorderRadius.circular(
                AStyling.borderRadius * AStyling.getScaleFactor(context)
            )
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FaIcon(iconData,color: AColors.yellow,size: iconSize,),
        onPressed: onPressed,
      ),
    );
  }
}
