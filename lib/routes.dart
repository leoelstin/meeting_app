import 'package:flutter/material.dart';
import 'package:meeting_app/ui/home.dart';
import 'package:meeting_app/ui/meeting_planner.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => Home(),
    MeetingPlanner.meetingPlanner: (_) => MeetingPlanner(),
  };
}
