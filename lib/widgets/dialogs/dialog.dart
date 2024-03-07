import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
class AAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const AAlertDialog({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(title)
          : null,
      content: content != null
          ? Text(content)
          : null,
      actions: <Widget>[
        FlatButton(
          child: Text(_subtitle.confirm),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text(_subtitle.cancel),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
