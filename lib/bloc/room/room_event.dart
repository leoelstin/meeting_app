part of 'room_bloc.dart';

@immutable
abstract class RoomEvent {}

class FetchRoom extends RoomEvent {
  final DateTime start;

  FetchRoom({this.start});
}
