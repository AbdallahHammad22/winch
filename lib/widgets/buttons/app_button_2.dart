import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AButton2 extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final VoidCallback onPressed;

  const AButton2({Key key, this.text, this.color, this.borderColor, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4
      ),
      decoration: BoxDecoration(
        color: AColors.lightGrey,
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
      child: MaterialButton(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            text??"",
            style: Theme.of(context).textTheme.bodyText2,
            textScaleFactor: AStyling.getScaleFactor(context),
          ),
        ),
        onPressed: onPressed
      ),
    );
  }
}
