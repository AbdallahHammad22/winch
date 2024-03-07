import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AButton extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final Color color;
  final Color borderColor;
  final VoidCallback onPressed;

  const AButton({Key key, this.text, this.color, this.borderColor, this.onPressed,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color:  color ?? AColors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AStyling.getBorderRadius(context)
        ),
        side: BorderSide(
            color: borderColor ?? AColors.yellow,
            width: borderColor == null ? 0 : 2,
            style: BorderStyle.solid
        ),
      ),
      padding: padding ?? EdgeInsets.symmetric(
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
