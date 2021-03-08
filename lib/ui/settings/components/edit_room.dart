import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_app/bloc/room/room_bloc.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/ui/settings/components/color_picker.dart';

class EditRoom extends StatefulWidget {
  final CommonData data;

  const EditRoom({Key key, this.data}) : super(key: key);

  @override
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  CommonData room = CommonData();

  @override
  void initState() {
    super.initState();
    room = widget?.data;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Edit Room'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.data?.name,
                    onChanged: (value) {
                      room.name = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ColorPicker(
                          onSelect: (value) {
                            setState(() {
                              room.color = value.value.toString();
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                    color: Color(int.parse(room?.color)),
                    margin: EdgeInsets.all(4),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  room.id = widget?.data?.id;
                  BlocProvider.of<RoomBloc>(context)
                      .add(UpdateRoom(room: room));
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: kToolbarHeight,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
