import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/sizing.dart';

class ATimePicker extends StatelessWidget {
  final String date;
  final Function(String) onDatePicker;

  const ATimePicker({Key key, this.date, this.onDatePicker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AStyling.getBorderRadius(context)
          )
      ),
      color: Theme.of(context).accentColor,
      child: Text(
        date ?? "Pick Time",
        style: Theme.of(context).textTheme.headline6,
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
      onPressed: () async {
        TimeOfDay time = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );
        print(time);
        onDatePicker(time.format(context));
      },
    );
  }
}
