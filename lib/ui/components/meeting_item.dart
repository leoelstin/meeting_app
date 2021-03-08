import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/ui/meeting_planner.dart';

class MeetingItem extends StatelessWidget {
  final Meeting meeting;

  const MeetingItem({Key key, this.meeting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              MeetingPlanner.meetingPlanner,
              arguments: MeetingPlannerData(
                meeting: meeting,
                update: true,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    '${meeting?.title ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    '${meeting?.description ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${meeting?.durationText() ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Icon(
                        CupertinoIcons.location,
                        size: 12,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${meeting?.roomName ?? ''}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.arrow_up_right_circle,
                            size: 13,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${meeting?.priorityName() ?? ''}',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.indigo,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('      Join     '),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
