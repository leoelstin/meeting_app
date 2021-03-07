import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/ui/components/date_picker.dart';
import 'package:meeting_app/ui/components/picker.dart';

class MeetingPlanner extends StatefulWidget {
  static const meetingPlanner = '/meetingPlanner';

  @override
  _MeetingPlannerState createState() => _MeetingPlannerState();
}

class _MeetingPlannerState extends State<MeetingPlanner> {
  // fromTime

  DateFormat format = DateFormat('dd MMM, hh:mm aa');
  DateTime fromDateTime;
  DateTime endDateTime;

  // endTime ( default current time + 30 minutes )
  CommonData room;
  CommonData priority;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    int minutes = DateTime.now().minute;
    int mod = minutes % 30;
    fromDateTime = DateTime.now().add(
      Duration(minutes: mod < 4 ? -mod : (30 - mod)),
    );
    endDateTime = fromDateTime.add(
      Duration(
        minutes: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Meeting'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0,
        child: SafeArea(
          child: InkWell(
            onTap: () {
              formKey.currentState.save();
              if (formKey.currentState.validate()) {
                if (room == null) {
                  final snackBar =
                      SnackBar(content: Text('Please pick a location!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: kToolbarHeight,
              child: Text(
                'Create Meeting',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: Icon(Icons.edit),
                labelText: 'Title',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Please enter the title !'
                    : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Description',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Please enter the description !'
                    : null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(
                  width: 16,
                ),
                Text('Duration')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      DatePicker(
                        context,
                        initialDate: fromDateTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            fromDateTime = value;
                          });
                        },
                      ).show();
                    },
                    child: Row(
                      children: [
                        Text('Start'),
                        Spacer(),
                        Text('${format.format(fromDateTime)}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      DatePicker(
                        context,
                        initialDate: endDateTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            endDateTime = value;
                          });
                        },
                      ).show();
                    },
                    child: Row(
                      children: [
                        Text('End'),
                        Spacer(),
                        Text('${format.format(endDateTime)}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Picker(
                  onSelected: (value) {
                    setState(() {
                      room = value;
                    });
                  },
                  type: PickerType.LOCATION,
                ).show(context);
              },
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 16,
                  ),
                  Text('${room?.name ?? 'Location'}'),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 14,
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Picker(
                  onSelected: (value) {
                    setState(() {
                      priority = value;
                    });
                  },
                  type: PickerType.PRIORITY,
                ).show(context);
              },
              child: Row(
                children: [
                  Icon(Icons.priority_high),
                  SizedBox(
                    width: 16,
                  ),
                  Text('${priority?.name ?? 'Priority'}'),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 14,
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
