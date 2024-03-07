import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class ATitle extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  final bool center;
  const ATitle(this.text, {Key key,this.padding,this.center= false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Row(
        mainAxisAlignment: center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
            textScaleFactor: AStyling.getScaleFactor(context),
          ),
        ],
      ),
    );
  }
}
