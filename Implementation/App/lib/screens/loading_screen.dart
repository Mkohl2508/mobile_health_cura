import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/master_context.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_file.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/residence/residence.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/screens/home_screen.dart';

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

Residence _initResidence() {
  return Residence(
      id: "1residence",
      street: "Musterstraße 1",
      zipCode: "12345",
      city: "Musterstadt",
      country: "Musterland");
}

Doctor _initDoctor() {
  return Doctor(
      id: "1doctor",
      firstName: "Peter",
      surname: "Lustig",
      degree: "Dr. med.",
      birthDate: DateTime(1955, 11, 20),
      type: "Lungenfacharzt",
      residence: _initResidence());
}

PatientFile _initPatientFile() {
  return PatientFile(
      id: "1patientFile",
      wounds: [_initWound()],
      attendingDoctor: _initDoctor());
}

Room _initRoom() {
  return Room(number: 1, name: "Regenbogen Raum");
}

Patient _initPatient() {
  return Patient(
      id: "1patient",
      birthDate: DateTime(1937, 11, 01),
      firstName: "Ullricke",
      surname: "Steinbock",
      patientFile: _initPatientFile(),
      residence: _initResidence(),
      room: _initRoom());
}

Nurse _initNurse() {
  return Nurse(
    id: "1nurse",
    firstName: "Sophie",
    surname: "Splitter",
    birthDate: DateTime(1991, 04, 20),
    residence: _initResidence(),
  );
}

OldPeopleHome _initOldPeopleHome() {
  return OldPeopleHome(
      id: "1oldPeopleHome",
      name: "Alte Mensa",
      residence: _initResidence(),
      nurses: [_initNurse()],
      patients: [_initPatient()]);
}

Future<void> initMasterContext(BuildContext context) async {
  globals.masterContext.oldPeopleHomesList.add(_initOldPeopleHome());
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return HomeScreen();
  }));
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    // init mock data
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
