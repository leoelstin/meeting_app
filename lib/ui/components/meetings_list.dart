import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/meeting.dart';

import 'meeting_item.dart';

class MeetingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          Meeting meeting = Meeting(
            title: 'Maersk App Design',
            description:
                'Meeting to confirm the application design and fix the time duration to complete the task',
            duration: 30,
            startTime: 1615043249689,
            endTime: 1615045271460,
            priority: 3,
            reminder: 15,
            roomName: 'Main Meeting Hall',
            roomId: 0,
          );
          return MeetingItem(
            meeting: meeting,
          );
        },
      ),
    );
  }
}
