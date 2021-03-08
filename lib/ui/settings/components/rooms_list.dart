import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/room/room_bloc.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/ui/settings/components/edit_room.dart';

class RoomsList extends StatefulWidget {
  static const route = '/roomsList';

  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<RoomBloc>(context).add(
        FetchRoom(
          start: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        Navigator.popUntil(
          context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rooms List'),
        ),
        body: BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            if (state is RoomsLoaded) {
              return ListView.builder(
                itemCount: state.rooms.length,
                itemBuilder: (context, index) {
                  CommonData data = state.rooms[index];
                  return ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => EditRoom(
                          data: data,
                        ),
                      );
                    },
                    title: Text('${data?.name}'),
                    leading: Container(
                      color: Color(
                        int.parse(data.color),
                      ),
                      width: 30,
                      height: 20,
                    ),
                    trailing: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.grey,
                    ),
                  );
                },
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
