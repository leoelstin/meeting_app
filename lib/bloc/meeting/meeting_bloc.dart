import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/model/repository/meetings_repository.dart';
import 'package:meta/meta.dart';

part 'meeting_event.dart';

part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  MeetingBloc() : super(MeetingInitial());
  final MeetingsRepository _repository = MeetingsRepository();

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is CreateMeeting) {
      await _repository.createTodo(event?.meeting);
      add(LoadMeeting());
    }
    if (event is LoadMeeting) {
      List<Meeting> meetings = await _repository.getAllMeetings();
      // meetings.sort((a, b) => a?.priority?.compareTo(b?.priority));
      yield MeetingsLoaded(meetings);
      yield UpdateMeeting(null);
    }
  }
}
