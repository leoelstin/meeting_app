import 'package:flutter/material.dart';
import 'package:meeting_app/ui/settings/components/office_hours.dart';
import 'package:meeting_app/ui/settings/components/rooms_list.dart';

class Settings extends StatefulWidget {
  static const route = '/settings';

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('General'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, RoomsList.route);
            },
            title: Text('Update Meeting Rooms'),
            trailing: Icon(Icons.arrow_right),
          ),
          Divider(),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return OfficeHours();
                },
              );
            },
            title: Text('Update Office Hours'),
            trailing: Icon(Icons.arrow_right),
          ),
          Divider(),
          ListTile(
            title: Text('Timezone'),
            trailing: Icon(Icons.arrow_right),
          ),
          Divider(),
          ListTile(
            title: Text('Reminders'),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
