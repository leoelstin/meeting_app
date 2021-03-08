part of 'meeting_bloc.dart';

@immutable
abstract class MeetingEvent {}

class CreateMeeting extends MeetingEvent {
  final Meeting meeting;

  CreateMeeting({this.meeting});
}

class UpdateMeeting extends MeetingEvent {
  final Meeting meeting;

  UpdateMeeting({this.meeting});
}

class LoadMeeting extends MeetingEvent {}
