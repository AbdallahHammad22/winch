import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/widgets/titles/app_title.dart';
class FormTopCover extends StatelessWidget {
  final String title;

  const FormTopCover(this.title,{Key key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          width: MediaQuery.of(context).size.width,
          image: AssetImage("assets/images/cover_background.png"),
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 38 * AStyling.getScaleFactor(context),
            right: 38 * AStyling.getScaleFactor(context),
            bottom: 120
          ),
          child:  Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
