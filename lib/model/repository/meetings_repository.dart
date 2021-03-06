import 'dart:async';

import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/model/data_base/data_base_provider.dart';

class MeetingsRepository {
  final dbProvider = DatabaseProvider.dbProvider;

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

    result = await db.query(
      meetingTable,
    );

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
