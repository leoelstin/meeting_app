import 'package:flutter/material.dart';
import 'package:meeting_app/data_model/common.dart';

class ColorPicker extends StatefulWidget {
  final CommonData data;
  final ValueChanged<Color> onSelect;

  const ColorPicker({Key key, this.data, this.onSelect}) : super(key: key);

  @override
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<ColorPicker> {
  CommonData data = CommonData();

  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.indigo,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            Color color = colors[index];
            return InkWell(
              onTap: () {
                widget?.onSelect(color);
                Navigator.pop(context);
              },
              child: Container(
                height: 20,
                color: color,
                margin: EdgeInsets.all(4),
              ),
            );
          },
        ),
      ),
    );
  }
}
