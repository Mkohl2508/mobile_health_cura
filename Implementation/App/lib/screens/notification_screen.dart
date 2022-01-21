import 'dart:io';

import 'package:cura/globals.dart';
import 'package:cura/model/enums/enum_converter.dart';
import 'package:cura/model/enums/notification_status_enum.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/wound_notification.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _localUserId = "me1";

  Widget notifciationTemplate(WoundNotification notif) {
    var nursingHome = masterContext.getById(QueryWrapper.nursingHomeID);
    var room = nursingHome!.getRoomById(notif.roomId);
    var patient = room!.getPatientById(notif.patientId);
    var nurse =
        notif.nurseId != null ? nursingHome.getNurseById(notif.nurseId!) : null;
    var wound = patient.patientFile.getWoundById(notif.woundId);

    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Name: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.grey[600]),
                    ),
                    TextSpan(
                        text: patient.fullName(),
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]))
                  ])),
                ),
                Text(
                  EnumConverter.notificationStatusEnumToString(notif.status),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: notif.status == NotificationStatus.toDo
                          ? Colors.red
                          : (notif.status == NotificationStatus.inProgress
                              ? Colors.yellow[700]
                              : Colors.green[600])),
                )
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Location: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey[600]),
                  ),
                  TextSpan(
                      text: wound!.location,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]))
                ])),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            RichText(
              text: TextSpan(
                text: notif.description != null ? notif.description! : '-',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            _initStatusButton(notif, nurse)
          ],
        ),
      ),
    );
  }

  Widget _initStatusButton(WoundNotification notif, Nurse? nurse) {
    if (notif.status == NotificationStatus.toDo) {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColors.cure_brightBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: AppColors.cura_cyan)))),
        onPressed: () async {
          //change status to in Progress
          setState(() {
            notif.status = NotificationStatus.inProgress;
            notif.nurseId = masterContext.loggedNurse!.id;
          });
        },
        child:
            const Text('Start', style: TextStyle(color: AppColors.cura_cyan)),
      );
    } else if (notif.status == NotificationStatus.inProgress) {
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Nurse: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey[600]),
              ),
              Text(
                nurse!.fullName(),
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              )
            ],
          ),
          _localUserId == notif.nurseId!
              ? ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.cure_brightBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(color: AppColors.cura_cyan)))),
                  onPressed: () async {
                    //change status to in Progress
                    setState(() {
                      notif.status = NotificationStatus.done;
                    });
                  },
                  child: const Text('Done',
                      style: TextStyle(color: AppColors.cura_cyan)),
                )
              : Container()
        ],
      );
    } else {
      return Container();
    }
  }

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
                  children: masterContext
                      .getById(QueryWrapper.nursingHomeID)!
                      .notifications
                      .map((notif) => notifciationTemplate(notif))
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }
}
