import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/ui/components/text.dart';
import 'package:meeting_app/ui/meeting_planner.dart';

import 'components/meetings_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '${Texts.HOME_TITLE}',
        ),
        leading: Icon(
          CupertinoIcons.calendar,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                MeetingPlanner.meetingPlanner,
              );
            },
          ),
        ],
      ),
      body: MeetingsList(),
    );
  }
}
