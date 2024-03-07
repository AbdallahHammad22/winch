import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class NoItemFound extends StatelessWidget {
  final String message;
  final Widget actionButton;

  const NoItemFound({
    Key key,
    this.message, this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size =  MediaQuery.of(context).size.width/ 1.5;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message ?? "no item found",
           style: Theme.of(context).textTheme.headline6,
          textScaleFactor: AStyling.getScaleFactor(context),
          ),
          SizedBox(height: 8 * AStyling.getScaleFactor(context),),
          actionButton ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
