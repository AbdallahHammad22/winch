import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';

class ALoading extends StatelessWidget {
  final int progress;

  const ALoading({Key key, this.progress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FlareActor(
              "assets/flares/wynch_loading.flr",
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              animation: "loading"),
        ),
        Visibility(
          visible: progress != null,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Text(
                "$progress %",
                style: Theme.of(context).textTheme.subtitle1,
                textScaleFactor: AStyling.getScaleFactor(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
