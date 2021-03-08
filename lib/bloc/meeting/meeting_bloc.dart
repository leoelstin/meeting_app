import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/model/repository/meetings_repository.dart';
import 'package:meta/meta.dart';

part 'meeting_event.dart';

part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitial());
  final MeetingsRepository _repository = MeetingsRepository();

  DateTime dateTime;

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is CreateMeeting) {
      await _repository.createTodo(event?.meeting);

      add(LoadMeeting(dateTime));
    }

    if (event is UpdateMeeting) {
      await _repository.updateMeeting(event?.meeting);
      add(LoadMeeting(dateTime));
    }
    if (event is LoadMeeting) {
      if (event.dateTime != null) {
        dateTime = event.dateTime;
      }
      List<Meeting> meetings = await _repository.getAllMeetings();

      String date = dateTime.toIso8601String().split('T').first;

      meetings = meetings.where((element) {
        String date2 = DateTime.fromMillisecondsSinceEpoch(element.startTime)
            .toIso8601String()
            .split('T')
            .first;
        return date == date2;
      }).toList();
      meetings.sort((a, b) => b?.priority?.compareTo(a?.priority));
      yield MeetingsLoaded(meetings);
    }
  }
}
