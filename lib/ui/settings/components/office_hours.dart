import 'package:flutter/material.dart';
import 'package:meeting_app/model/repository/office_hours.dart';

class OfficeHours extends StatefulWidget {
  @override
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<OfficeHours> {
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
              title: Text('Start Time  '),
              trailing: Icon(Icons.edit),
              subtitle: Text(
                '${OfficeRepository.startHour} :${OfficeRepository.startMin} ',
              ),
            ),
            Divider(),
            ListTile(
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
