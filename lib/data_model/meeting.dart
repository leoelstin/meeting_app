import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:meeting_app/data_model/common.dart';

Meeting meetingFromJson(String str) => Meeting.fromJson(json.decode(str));

String meetingToJson(Meeting data) => json.encode(data.toJson());

class Meeting {
  Meeting({
    this.id,
    this.startTime,
    this.endTime,
    this.title,
    this.description,
    this.duration,
    this.roomName,
    this.roomId,
    this.priority,
    this.reminder,
  });

  int id;
  int startTime;
  int endTime;
  String title;
  String description;
  int duration;
  String roomName;
  int roomId;
  int priority;
  int reminder;

  CommonData get room => CommonData(name: roomName, id: roomId);

  CommonData get priorityData => CommonData(name: priorityName(), id: priority);

  String priorityName() {
    switch (priority) {
      case 0:
        return 'Low';
      case 1:
        return 'Medium';
      case 2:
        return 'High';
      default:
        return 'Low';
    }
  }

  String durationText() {
    String from = DateFormat('hh:mm aa').format(
      DateTime.fromMillisecondsSinceEpoch(startTime),
    );
    String end = DateFormat('hh:mm aa').format(
      DateTime.fromMillisecondsSinceEpoch(endTime),
    );

    return '$from - $end';
  }

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        roomName: json["room_name"],
        roomId: json["room_id"],
        priority: json["priority"],
        reminder: json["reminder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime,
        "endTime": endTime,
        "title": title,
        "description": description,
        "duration": duration,
        "room_name": roomName,
        "room_id": roomId,
        "priority": priority,
        "reminder": reminder,
      };
}
