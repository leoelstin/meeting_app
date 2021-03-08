import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/model/repository/meetings_repository.dart';

enum PickerType { LOCATION, PRIORITY }

class Picker {
  final ValueChanged<CommonData> onSelected;
  final PickerType type;

  Picker({
    @required this.onSelected,
    @required this.type,
  });

  void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _LocationWidget(
          onSelected: onSelected,
          type: type,
        );
      },
    );
  }
}

class _LocationWidget extends StatefulWidget {
  final ValueChanged<CommonData> onSelected;
  final PickerType type;

  const _LocationWidget({Key key, this.onSelected, this.type})
      : super(key: key);

  @override
  __LocationWidgetState createState() => __LocationWidgetState();
}

class __LocationWidgetState extends State<_LocationWidget> {
  List<CommonData> list = [];

  @override
  void initState() {
    super.initState();
    if (widget?.type == PickerType.LOCATION) {
    } else {
      list = MeetingsRepository().priorities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              "Please select the ${widget?.type == PickerType.LOCATION ? 'Location' : 'Priority'}  ",
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
      ),
    );
  }
}
