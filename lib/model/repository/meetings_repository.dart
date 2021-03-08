import 'dart:async';

import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/model/data_base/data_base_provider.dart';

class MeetingsRepository {
  final dbProvider = DatabaseProvider.dbProvider;

  List<CommonData> rooms() {
    return [
      CommonData(id: 0, name: 'Main Meeting Room'),
      CommonData(id: 1, name: 'CH1 Meeting Room'),
      CommonData(id: 2, name: 'CH2 Meeting Room'),
      CommonData(id: 3, name: 'CH3 Mini Room'),
    ];
  }

  List<CommonData> priorities() {
    return [
      CommonData(id: 0, name: 'Low'),
      CommonData(id: 1, name: 'Medium'),
      CommonData(id: 2, name: 'High'),
    ];
  }

  Future getRooms({DateTime start, DateTime end}) async {
    List<Meeting> meetings = await getAllMeetings();
    meetings.where(
      (element) {
        return (!start.isAtSameMomentAs(
                    DateTime.fromMillisecondsSinceEpoch(element.startTime)) ||
                !start.isAfter(
                    DateTime.fromMillisecondsSinceEpoch(element.startTime))) &&
            !start
                .isBefore(DateTime.fromMillisecondsSinceEpoch(element.endTime));
      },
    );

    Set<int> bookedRooms = meetings.map((e) => e.roomId).toSet();
    List<CommonData> roomList = [];
    rooms().forEach((element) {
      roomList.add(
        CommonData(
          id: element.id,
          name: element.name,
          isAvailable: !bookedRooms.contains(element?.id),
        ),
      );
    });

    return roomList;
  }

  //add a new meeting to db
  Future<int> createTodo(Meeting meeting) async {
    final db = await dbProvider.database;
    var result = db.insert(meetingTable, meeting.toJson());
    return result;
  }

  //Get All the meeting from local db
  Future<List<Meeting>> getAllMeetings() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    int currentMilli = DateTime.now().millisecondsSinceEpoch;
    result = await db.query(meetingTable, where: 'startTime >= $currentMilli');

    List<Meeting> meetings = result.isNotEmpty
        ? result.map((item) => Meeting.fromJson(item)).toList()
        : [];
    return meetings;
  }

  //Update  meeting based on [id]
  Future<int> updateMeeting(Meeting meeting) async {
    final db = await dbProvider.database;

    var result = await db.update(meetingTable, meeting.toJson(),
        where: "id = ?", whereArgs: [meeting.id]);

    return result;
  }

  ///Delete  meeting based on [id]
  Future<int> deleteMeeting(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(meetingTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
