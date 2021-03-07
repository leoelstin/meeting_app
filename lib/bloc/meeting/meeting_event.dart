part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent {}

class CreateMeeting extends MeetingEvent {
  final Meeting meeting;

  CreateMeeting({this.meeting});
}

class LoadMeeting extends MeetingEvent {}
