import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/model/repository/office_hours.dart';
import 'package:meeting_app/ui/components/date_picker.dart';

class OfficeHours extends StatefulWidget {
  @override
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<OfficeHours> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Office  Timing ',
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                DateTime dateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  OfficeRepository.startHour,
                  OfficeRepository.startMin,
                );
                DatePicker(
                  context,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (DateTime value) {
                    OfficeRepository.startHour = value.hour;
                    OfficeRepository.startMin = value.minute;
                    setState(() {});
                  },
                ).show();
              },
              title: Text('Start Time  '),
              trailing: Icon(Icons.edit),
              subtitle: Text(
                '${OfficeRepository.startHour} :${OfficeRepository.startMin} ',
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                DateTime dateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  OfficeRepository.startHour,
                  OfficeRepository.startMin,
                );
                DatePicker(
                  context,
                  initialDate: dateTime,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (DateTime value) {
                    OfficeRepository.endHour = value.hour;
                    OfficeRepository.endMin = value.minute;
                    setState(() {});
                  },
                ).show();
              },
              title: Text('End Time'),
              trailing: Icon(Icons.edit),
              subtitle: Text(
                '${OfficeRepository.endHour} :${OfficeRepository.endMin} ',
              ),
            )
          ],
        ),
      ),
    );
  }
}
