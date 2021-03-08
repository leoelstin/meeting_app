part of 'room_bloc.dart';

@immutable
abstract class RoomState {}

class RoomInitial extends RoomState {}
class RoomUpdated extends RoomState {}

class RoomsLoaded extends RoomState {
  final List<CommonData> rooms;

  RoomsLoaded(this.rooms);
}
