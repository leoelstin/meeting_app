import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/bloc/room/room_bloc.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/ui/components/date_picker.dart';

import 'meeting_item.dart';

class MeetingsList extends StatefulWidget {
  @override
  _MeetingsListState createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  DateTime dateTime = DateTime.now();
  var format = DateFormat('dd MMM, yyyy');

  @override
  void initState() {
    super.initState();

    /// Waits till the first frame of the UI is built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// add the LoadMeeting Event to meetings bloc
      /// to initialize the list
      BlocProvider.of<MeetingBloc>(context).add(
        LoadMeeting(dateTime),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state is RoomUpdated) {
          BlocProvider.of<MeetingBloc>(context).add(
            LoadMeeting(dateTime),
          );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('${format.format(dateTime)}'),
                Spacer(),
                TextButton.icon(
                  onPressed: () {
                    DatePicker(
                      context,
                      onDateTimeChanged: (value) {
                        setState(() {
                          dateTime = value;
                        });
                        BlocProvider.of<MeetingBloc>(context).add(
                          LoadMeeting(dateTime),
                        );
                      },
                      initialDate: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                    ).show();
                  },
                  icon: Icon(
                    Icons.date_range,
                    size: 18,
                  ),
                  label: Text(
                    'Change',
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MeetingBloc, MeetingState>(
            buildWhen: (prv, cur) {
              /// builder will be called only when the meeting is either loading or
              /// loaded. So that it wont rebuild for other states
              return cur is LoadingMeetings ||
                  cur is MeetingsLoaded ||
                  cur is MeetingInitial;
            },
            builder: (context, state) {
              if (state is LoadingMeetings || state is MeetingInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Please wait '),
                  ],
                );
              }

              if (state is MeetingsLoaded) {
                if (state.meetings.isEmpty) {
                  return Center(
                    child: Text('No Meetings Found !'),
                  );
                }
                return SafeArea(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state?.meetings?.length ?? 0,
                    itemBuilder: (context, index) {
                      Meeting meeting = state.meetings[index];
                      return MeetingItem(
                        meeting: meeting,
                      );
                    },
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
