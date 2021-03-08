import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/model/data_base/data_base_provider.dart';

class MeetingsRepository {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<CommonData>> rooms() async {
    List<CommonData> list = [
      CommonData(
        id: 0,
        name: 'Main Meeting Room',
        color: Colors.blue.value.toString(),
      ),
      CommonData(
        id: 1,
        name: 'CH1 Meeting Room',
        color: Colors.green.value.toString(),
      ),
      CommonData(
        id: 2,
        name: 'CH2 Meeting Room',
        color: Colors.red.value.toString(),
      ),
      CommonData(
        id: 3,
        name: 'CH3 Mini Room',
        color: Colors.brown.value.toString(),
      ),
    ];
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(roomsTable);

    List<CommonData> roomList = result.isNotEmpty
        ? result.map((item) => CommonData.fromJson(item)).toList()
        : [];

    if (roomList.isEmpty) {
      for (var value in list) {
        await db.insert(roomsTable, value.toJson());
      }
      result = await db.query(roomsTable);
    }

    roomList = result.isNotEmpty
        ? result.map((item) => CommonData.fromJson(item)).toList()
        : [];
    return roomList;
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
    meetings = meetings.where(
      (element) {
        bool firstValidation = (!start.isAtSameMomentAs(
                DateTime.fromMillisecondsSinceEpoch(element.startTime)) ||
            !start.isAfter(
              DateTime.fromMillisecondsSinceEpoch(element.startTime),
            ));
        bool second = start
            .isBefore(DateTime.fromMillisecondsSinceEpoch(element.endTime));
        return firstValidation && second;
      },
    ).toList();

    Set<int> bookedRooms = meetings.map((e) => e.roomId).toSet();
    List<CommonData> roomList = [];
    List<CommonData> tempRoom = await rooms();
    tempRoom.forEach((element) {
      roomList.add(
        CommonData(
          id: element.id,
          name: element.name,
          color: element.color,
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
    List<CommonData> roomList = await rooms();

    List<Meeting> meetings = result.isNotEmpty
        ? result.map((item) {
            Meeting meeting = Meeting.fromJson(item);
            CommonData data = roomList.firstWhere(
              (element) => element.id == meeting.roomId,
            );
            meeting.roomColor = data.color;
            return meeting;
          }).toList()
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

  //Update  meeting based on [id]
  Future<int> updateRoom(CommonData data) async {
    final db = await dbProvider.database;

    var result = await db.update(roomsTable, data.toJson(),
        where: "id = ?", whereArgs: [data.id]);

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
