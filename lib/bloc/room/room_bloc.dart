import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/model/repository/meetings_repository.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc({this.meetingBloc}) : super(RoomInitial());
  final MeetingBloc meetingBloc;
  MeetingsRepository _repository = MeetingsRepository();

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is FetchRoom) {
      List<CommonData> rooms = await _repository.getRooms(start: event?.start);
      yield RoomsLoaded(rooms);
    }
    if (event is UpdateRoom) {
      await _repository.updateRoom(event?.room);
      yield RoomUpdated();
      List<CommonData> rooms = await _repository.getRooms(
        start: DateTime.now(),
      );
      yield RoomsLoaded(rooms);
    }
  }
}
