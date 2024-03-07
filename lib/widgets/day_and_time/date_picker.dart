import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';

class DatePicker extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onDatePicker;

  const DatePicker({Key key, this.date, this.onDatePicker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              AStyling.borderRadius * AStyling.getScaleFactor(context)
          )
      ),
      color: Theme.of(context).accentColor,
      child: Text(
        date == null ? _subtitle.pickDate :
        DateFormat.yMd().add_jm().format(date),
        style: Theme.of(context).textTheme.headline6,
        textScaleFactor: AStyling.getScaleFactor(context),
      ),
      onPressed: () async {
        DateTime datetime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))
        );
        if(datetime == null)
          return;
        TimeOfDay time = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if(time != null)
          datetime = datetime.add(Duration(hours: time.hour,minutes: time.minute));

        onDatePicker(datetime);
      },
    );
  }
}
