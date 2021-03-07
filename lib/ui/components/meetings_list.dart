import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/data_model/meeting.dart';

import 'meeting_item.dart';

class MeetingsList extends StatefulWidget {
  @override
  _MeetingsListState createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  @override
  void initState() {
    super.initState();

    /// Waits till the first frame of the UI is built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// add the LoadMeeting Event to meetings bloc
      /// to initialize the list
      BlocProvider.of<MeetingBloc>(context).add(
        LoadMeeting(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingBloc, MeetingState>(
      buildWhen: (prv, cur) {
        /// builder will be called only when the meeting is either loading or
        /// loaded. SO that it wont rebuild for other states
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
    );
  }
}
