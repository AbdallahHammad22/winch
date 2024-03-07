import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';

class AOutLineButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final VoidCallback onPressed;

  const AOutLineButton({Key key, this.text, this.color, this.borderColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(
        color: borderColor ?? Theme.of(context).accentColor,
        width: 2,
        style: BorderStyle.solid
      ),
      color:  color ?? AColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AStyling.getBorderRadius(context)
        )
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * AStyling.getScaleFactor(context),
        vertical: 12 * AStyling.getScaleFactor(context)
      ),
      child: Text(
        text??"",
        style: Theme.of(context).textTheme.bodyText2,
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
      onPressed: onPressed
    );
  }
}
