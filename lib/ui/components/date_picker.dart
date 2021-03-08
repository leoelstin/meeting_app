import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker {
  BuildContext context;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDate;
  final DateTime minimumDate;
  final CupertinoDatePickerMode mode;

  DatePicker(
    this.context, {
    this.minimumDate,
    @required this.onDateTimeChanged,
    this.initialDate,
    this.mode = CupertinoDatePickerMode.dateAndTime,
  });

  void show() {
    DateTime time = initialDate;
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 300,
            child: Stack(
              children: <Widget>[
                CupertinoDatePicker(
                  mode: mode,
                  onDateTimeChanged: (date) {
                    time = date;
                    // onDateTimeChanged(date);
                  },
                  initialDateTime: initialDate == null ||
                          initialDate.isBefore(DateTime.now())
                      ? null
                      : initialDate,
                  minimumDate: minimumDate  ,
                  maximumDate: DateTime(DateTime.now().year + 3),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                    child: Text('Done'),
                    onPressed: () => {
                      onDateTimeChanged(time),
                      Navigator.pop(context),
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
