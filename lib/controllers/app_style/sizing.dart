import 'package:flutter/material.dart';
class AStyling {
  AStyling._();

  static const double borderRadius = 6;

  static const BoxShadow boxShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 2,
    offset: Offset(0,2)
  );

  static double getBorderRadius(BuildContext context){
    return borderRadius * getScaleFactor(context);
  }

  static double getScaleFactor(BuildContext context){
    return MediaQuery.of(context).orientation == Orientation.portrait
        ?  MediaQuery.of(context).size.width/(360) > 1.5
        ? 1.5 : MediaQuery.of(context).size.width/(360)
        : MediaQuery.of(context).size.height/(360) > 1.5
        ? 1.5 : MediaQuery.of(context).size.height/(360);
  }

}