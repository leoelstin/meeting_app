import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker {
  BuildContext context;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDate;

  DatePicker(
    this.context, {
    @required this.onDateTimeChanged,
    @required this.initialDate,
  });

  void show() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 300,
            child: Stack(
              children: <Widget>[
                CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (date) {
                    onDateTimeChanged(date);
                  },
                  initialDateTime: initialDate,
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime(DateTime.now().year + 3),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CupertinoButton(
                    child: Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
