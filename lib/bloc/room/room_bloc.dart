import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/model/repository/meetings_repository.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';

part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial());
  MeetingsRepository _repository = MeetingsRepository();

  @override
  Stream<RoomState> mapEventToState(
    RoomEvent event,
  ) async* {
    if (event is FetchRoom) {
      List<CommonData> rooms = await _repository.getRooms(start: event?.start);
      yield RoomsLoaded(rooms);
    }
  }
}
