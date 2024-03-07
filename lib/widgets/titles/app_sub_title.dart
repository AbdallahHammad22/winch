import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class ASubTitle extends StatelessWidget {
  final String text;
  final EdgeInsets padding;
  const ASubTitle(this.text, {Key key,this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(text,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
          fontWeight: FontWeight.normal
        ),
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
    );
  }
}
