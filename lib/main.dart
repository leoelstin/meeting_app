import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/routes.dart';

import 'bloc/room/room_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
          create: (context) => RoomBloc(),
        ),
        BlocProvider<MeetingBloc>(
          create: (context) {
            return MeetingBloc();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meeting App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        routes: Routes.routes,
      ),
    );
  }
}
