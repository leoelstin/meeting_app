import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/bloc/meeting/meeting_bloc.dart';
import 'package:meeting_app/bloc/room/room_bloc.dart';
import 'package:meeting_app/data_model/common.dart';
import 'package:meeting_app/data_model/meeting.dart';
import 'package:meeting_app/ui/components/date_picker.dart';
import 'package:meeting_app/ui/components/picker.dart';
import 'package:meeting_app/ui/components/rooms_picker.dart';

class MeetingPlanner extends StatefulWidget {
  static const meetingPlanner = '/meetingPlanner';

  @override
  _MeetingPlannerState createState() => _MeetingPlannerState();
}

class _MeetingPlannerState extends State<MeetingPlanner> {
  DateFormat format = DateFormat('dd MMM, hh:mm aa');
  DateTime fromDateTime;
  DateTime endDateTime;
  String title;
  String description;

  // endTime ( default current time + 30 minutes )
  CommonData room;
  CommonData priority;
  GlobalKey<FormState> formKey = GlobalKey();

  int _defaultDuration = 30;
  MeetingPlannerData plannerData = MeetingPlannerData();

  // Controllers
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();

  bool edit = true;
  bool update = false;

  @override
  void initState() {
    super.initState();

    /// to setup the initial values
    initialSetup();

    /// waits till the first frame of the UI is visible
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// get the data from the modal route
      plannerData = ModalRoute.of(context).settings.arguments;
      if (plannerData?.meeting != null) {
        update = plannerData.update;
        edit = false;
        titleController.text = plannerData?.meeting?.title;
        descriptionController.text = plannerData?.meeting?.description;
        room = plannerData?.meeting?.room;
        priority = plannerData?.meeting?.priorityData;
        fromDateTime = DateTime.fromMillisecondsSinceEpoch(
            plannerData?.meeting?.startTime);
        endDateTime = DateTime.fromMillisecondsSinceEpoch(
          plannerData?.meeting?.endTime,
        );
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${plannerData?.meeting != null ? 'Meeting Details' : 'New Meeting'}',
        ),
        actions: [
          if (update)
            TextButton(
              onPressed: () {
                if (edit) {
                  validateEntry();
                  return;
                }
                setState(() {
                  edit = !edit;
                });
              },
              child: Text(
                '${edit ? 'Save' : 'Edit'}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: update
          ? null
          : BottomAppBar(
              color: Theme.of(context).primaryColor,
              elevation: 0,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    // validates the data
                    validateEntry();
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
              enabled: edit,
              controller: titleController,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                title = value;
              },
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
              enabled: edit,
              controller: descriptionController,
              onSaved: (value) {
                description = value;
              },
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
                    onTap: !edit
                        ? null
                        : () {
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
                    onTap: !edit
                        ? null
                        : () {
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
              onTap: !edit
                  ? null
                  : () {
                      openRoomPicker(context);
                    },
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 16,
                  ),
                  Text('${room?.name ?? 'Location'}'),
                  Spacer(),
                  if (edit)
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
              onTap: !edit
                  ? null
                  : () {
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
                  if (edit)
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

  /// Method to create the meeting object based on the user entered details
  void saveMeeting() {
    // creates a [meeting] object
    Meeting meeting = Meeting(
      // if update send the meeting id
      id: update ? plannerData?.meeting?.id : null,

      startTime: fromDateTime.millisecondsSinceEpoch,
      endTime: endDateTime.millisecondsSinceEpoch,
      title: title,
      description: description,
      roomId: room?.id,
      roomName: room?.name,
      reminder: 15,
      priority: priority?.id,
      duration: fromDateTime.difference(endDateTime).inMinutes,
    );

    /// adds the CreateMeeting event to MeetingBloc
    if (!update) {
      BlocProvider.of<MeetingBloc>(context).add(
        CreateMeeting(meeting: meeting),
      );
    } else {
      BlocProvider.of<MeetingBloc>(context).add(
        UpdateMeeting(meeting: meeting),
      );
    }
  }

  /// this method will create from and too times based on the current time
  /// the meeting start time will be rounded to the nearby half time

  void initialSetup() {
    int minutes = DateTime.now().minute;

    int mod = minutes % _defaultDuration;
    fromDateTime = DateTime.now().add(
      Duration(minutes: mod < 4 ? -mod : (30 - mod)),
    );
    endDateTime = fromDateTime.add(
      Duration(
        minutes: 30,
      ),
    );
  }

  void validateEntry() {
    formKey.currentState.save();

    /// This will validate the Title and Description field using the default form
    /// field validator
    if (formKey.currentState.validate()) {
      /// this will check if priority and location selected
      /// else shows a SnackBar with error
      if (room == null || priority == null) {
        final snackBar = SnackBar(
          content: Text(
            'Please pick a ${room == null ? 'Location' : 'Priority'}!',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        /// if validates save the data to local db
        saveMeeting();
      }
    }
  }

  void openRoomPicker(BuildContext context) {
    /// adds the fetch room event
    BlocProvider.of<RoomBloc>(context).add(
      FetchRoom(start: fromDateTime),
    );
    // open the room picker
    RoomPicker(
      onSelected: (value) {
        setState(() {
          room = value;
        });
      },
    ).show(context);
  }
}

class MeetingPlannerData {
  final bool update;
  final Meeting meeting;

  MeetingPlannerData({this.meeting, this.update = false});
}
