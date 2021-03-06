import 'dart:convert';

Meeting meetingFromJson(String str) => Meeting.fromJson(json.decode(str));

String meetingToJson(Meeting data) => json.encode(data.toJson());

class Meeting {
  Meeting({
    this.id,
    this.dateTime,
    this.title,
    this.description,
    this.duration,
    this.meetingRoom,
    this.priority,
    this.reminder,
  });

  String id;
  int dateTime;
  String title;
  String description;
  int duration;
  String meetingRoom;
  int priority;
  int reminder;

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["id"],
        dateTime: json["dateTime"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        meetingRoom: json["meeting_room"],
        priority: json["priority"],
        reminder: json["reminder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateTime": dateTime,
        "title": title,
        "description": description,
        "duration": duration,
        "meeting_room": meetingRoom,
        "priority": priority,
        "reminder": reminder,
      };
}
