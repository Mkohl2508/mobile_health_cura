import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/master_context.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/residence/residence.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/screens/home_screen.dart';
import 'package:cura/utils/query_wrapper.dart';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

Wound _initWound() {
  WoundEntry entry = WoundEntry(
      id: "1woundEntry",
      date: DateTime(2021, 11, 20),
      size: 5.10,
      status: "blutend");
  return Wound(
      id: "1wound",
      location: "Unterer Rücken",
      type: "Platzwunde",
      isHealed: false,
      startDate: DateTime(2021, 11, 20),
      woundEntrys: [entry]);
}

Future<Residence> _initResidence() async {
  var residenceID = "77XH3QnTfa9O8hgGCpzt";
  dynamic residence = await QueryWrapper.getResidence(residenceID);
  return Residence(
      id: residence.id,
      street: residence.data()["street"],
      zipCode: residence.data()["zipCode"],
      city: residence.data()["city"],
      country: residence.data()["country"]);
}

Future<Doctor> _initDoctor(doctorID) async {
  dynamic doctor = await QueryWrapper.getDoctor(doctorID);
  return Doctor(
      id: "1doctor",
      phoneNumber: "+49 15204381194",
      firstName: "Peter",
      surname: "Lustig",
      degree: "Dr. med.",
      birthDate: DateTime(1955, 11, 20),
      type: "Lungenfacharzt",
      residence: await _initResidence());
}

Future<PatientRecord> _initPatientFile() async {
  return PatientRecord(
      id: "1patientFile",
      wounds: [_initWound()],
      attendingDoctor: await _initDoctor("bla"));
}

Future<List<Patient>> _initPatient(roomID) async {
  List<Patient> initPatients = [];
  List<dynamic> patients = await QueryWrapper.getPatients(roomID);
  for (var patient in patients) {
    initPatients.add(Patient(
        id: patient.id,
        birthDate: patient.data()['birthDate'].toDate(),
        firstName: patient.data()['firstName'],
        surname: patient.data()['surname'],
        patientFile: await _initPatientFile(),
        residence: await _initResidence(), //patient.data()['residence']
        phoneNumber: patient.data()['phoneNumber']));
  }
  return initPatients;
}

Future<List<Room>> _initRoom() async {
  List<Room> initRooms = [];
  List<dynamic> rooms = await QueryWrapper.getRooms();
  for (var room in rooms) {
    initRooms.add(Room(
        number: room.data()['number'],
        name: room.data()['name'],
        patients: await _initPatient(room.id)));
  }
  return initRooms;
}

Future<List<Nurse>> _initNurse() async {
  List<Nurse> initNurses = [];
  List<dynamic> nurses = await QueryWrapper.getNurses();
  for (var nurse in nurses) {
    initNurses.add(Nurse(
      id: nurse.id,
      firstName: nurse.data()['firstName'],
      surname: nurse.data()['surname'],
      birthDate: nurse.data()['birthDate'].toDate(),
      residence: await _initResidence(), //nurse.data()['residence']
      phoneNumber: nurse.data()['phoneNumber'].toString(),
    ));
  }
  return initNurses;
}

Future<OldPeopleHome> _initOldPeopleHome() async {
  dynamic nursingHome = await QueryWrapper.getNursingHome();
  return OldPeopleHome(
      id: nursingHome.id,
      name: nursingHome.data()["name"],
      residence: await _initResidence(),
      nurses: await _initNurse(),
      rooms: await _initRoom());
}

Future<void> initMasterContext(BuildContext context) async {
  globals.masterContext.oldPeopleHomesList.add(await _initOldPeopleHome());
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  });
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    // init mock data
    return FutureBuilder<void>(
        future: initMasterContext(context),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen();
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Loading..."),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}
