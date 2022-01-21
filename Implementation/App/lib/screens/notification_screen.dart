import 'dart:io';

import 'package:cura/model/widget/AppColors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

Widget notifciationTemplate(Notif notif) {
  List<String> messages = [
    'The phase of the wound should have changed. Please check if the phase has changed.',
    'The wound has not healed in the last 12 weeks. It is now marked as a chronic wound. Please check if the assessment is still correct.',
    'The pain level of the patient has not decreased in the last three days. Please check on the patient.',
    'The size of the wound has not decreased in the last week. Please check if the treatment of the wound should be changed.',
    'The odor of the wound had been marked odd yesterday. Please check if the wound still smells odd.'
  ];

  if (notif.status == 'toDo') {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.grey[600]),
                ),
                Text(
                  'Patient Name',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                )
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                Text(
                  'Location: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.grey[600]),
                ),
                Text(
                  'upper arm',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                )
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              messages[notif.type],
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 6.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.cure_brightBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: AppColors.cura_cyan)))),
              onPressed: () async {
                //change status to in Progress
              },
              child: const Text('Start',
                  style: TextStyle(color: AppColors.cura_cyan)),
            ),
          ],
        ),
      ),
    );
  } else if (notif.status == 'inProgress') {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.grey[600]),
                ),
                Text(
                  'Patient Name',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                )
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                Text(
                  'Location: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.grey[600]),
                ),
                Text(
                  'upper arm',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                )
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              messages[notif.type],
              style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 6.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.cure_brightBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(color: AppColors.cura_cyan)))),
              onPressed: () async {
                //change status to Done
              },
              child: const Text('Done',
                  style: TextStyle(color: AppColors.cura_cyan)),
            ),
          ],
        ),
      ),
    );
  } else {
    return SizedBox.shrink();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notifs = [
    Notif('toDo', 0, 0, 0, 0),
    Notif('toDo', 1, 0, 0, 0),
    Notif('toDo', 2, 0, 0, 0),
    Notif('inProgress', 3, 0, 0, 0),
    Notif('Done', 4, 0, 0, 0),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom))
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.66,
                child: ListView(
                  children: notifs
                      .map((notif) => notifciationTemplate(notif))
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }
}

class Notif {
  String? status;
  int type = 0;
  int? woundID;
  int? patientID;
  int? nurseID;
  DateTime? date;

  Notif(this.status, this.type, this.woundID, this.patientID, this.nurseID);
}
