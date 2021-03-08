import 'package:flutter/material.dart';
import 'package:meeting_app/ui/home.dart';
import 'package:meeting_app/ui/meeting_planner.dart';
import 'package:meeting_app/ui/settings/components/rooms_list.dart';
import 'package:meeting_app/ui/settings/settings.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => Home(),
    MeetingPlanner.meetingPlanner: (_) => MeetingPlanner(),
    Settings.route: (_) => Settings(),
    RoomsList.route: (_) => RoomsList(),
  };
}
