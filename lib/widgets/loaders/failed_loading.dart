import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
class FailedLoading extends StatelessWidget {
  final String message;
  final VoidCallback onReload;

  const FailedLoading({
    Key key,
    this.message,
    this.onReload
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Visibility(
            visible: false,
            child: Expanded(
              flex: 3,
                child: Placeholder()
            ),
          ),
          SizedBox(height: 16,),
          Text(
            message ?? "Error Request Failed",
            style: Theme.of(context).textTheme.headline6,
            textScaleFactor: AStyling.getScaleFactor(context),
          ),
          SizedBox(height: 16,),
          OutlineButton(
            child: Text(
                _subtitle.tryAgain ?? "try again"
            ),
            onPressed: onReload,
          ),
          Spacer()
        ],
      ),
    );
  }
}
