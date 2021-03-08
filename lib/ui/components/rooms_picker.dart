import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/room/room_bloc.dart';
import 'package:meeting_app/data_model/common.dart';

class RoomPicker {
  final ValueChanged<CommonData> onSelected;

  RoomPicker({
    this.onSelected,
  });

  void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _LocationWidget(
          onSelected: onSelected,
        );
      },
    );
  }
}

class _LocationWidget extends StatefulWidget {
  final ValueChanged<CommonData> onSelected;

  const _LocationWidget({Key key, this.onSelected}) : super(key: key);

  @override
  __LocationWidgetState createState() => __LocationWidgetState();
}

class __LocationWidgetState extends State<_LocationWidget> {
  List<CommonData> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomsLoaded) {
            list = state.rooms;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Please select the Location",
                ),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  CommonData data = list[index];
                  return ListTile(
                    onTap: () {
                      widget?.onSelected(data);
                      Navigator.pop(context);
                    },
                    title: Text('${data.name}'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
