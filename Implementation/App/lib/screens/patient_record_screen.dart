import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/wound_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientRecordScreen extends StatefulWidget {
  final Patient patient;
  final Room room;

  /// This screen shows an overview of the patient record with current medication, wounds
  /// and emergency contacts. Medication and emergency contacts are only placeholder for now.
  const PatientRecordScreen(
      {Key? key, required this.patient, required this.room})
      : super(key: key);

  @override
  _PatientRecordScreenState createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cura_darkCyan,
        title: Text(
          widget.patient.fullName(),
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                child: Text(
                  "Patient record",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 700,
                height: 70,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      color: AppColors.cura_cyan,
                      width: 50,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.pills,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Medication",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Last update: 12.11.2021, 13:40",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      width: 80,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF065fc4),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WoundOverviewScreen(
                            patient: widget.patient,
                            room: widget.room,
                          )));
                },
                child: Container(
                  width: 700,
                  height: 70,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        color: AppColors.cura_cyan,
                        width: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 15),
                            child: Icon(
                              FontAwesomeIcons.bandAid,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Wounds",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Last update: 12.11.2021, 13:40",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )),
                      Container(
                        width: 80,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF065fc4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 700,
                height: 70,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      color: AppColors.cura_cyan,
                      width: 50,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Emergency contacts",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Last update: 15.08.2021, 17:20",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      width: 80,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF065fc4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
