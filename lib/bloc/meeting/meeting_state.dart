part of 'meeting_bloc.dart';

@immutable
abstract class MeetingState {}

class MeetingInitial extends MeetingState {}

class SavingMeeting extends MeetingState {}

class MeetingSaved extends MeetingState {}

class LoadingMeetings extends MeetingState {}

class MeetingsLoaded extends MeetingState {
  final List<Meeting> meetings;

  MeetingsLoaded(this.meetings);
}

