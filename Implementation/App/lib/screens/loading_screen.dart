import 'package:cura/model/general/doctor.dart';
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
      images: [
        "https://www.haeusliche-pflege.net/-/media/ahi/alle-netzwerke/digital/produkte-digital/elearning/0038_Expertenstandard-Pflege-von-Menschen-mit-chronischen-Wunden.png?bc=White&as=0&w=1000&hash=12DFA01B2A8FD46990BB13A311A3DE7C"
      ],
      status: "blutend");
  WoundEntry entry2 = WoundEntry(
      id: "2woundEntry",
      date: DateTime(2021, 11, 18),
      size: 5.10,
      images: [
        'https://www.draco.de/fileadmin/_processed_/4/3/csm_chronische-wunde_2313ccd551.jpg',
        'https://www.hartmann.info/-/media/wound/img/homesite-wunde_teaser_ulcus-cruris-venosum_phi21_02_03.png?h=270&iar=0&mw=868&w=525&rev=79ba654e383d4e8ba3006f3d8f7f481a&sc_lang=de-de&hash=D943076C221F102F181352CCE6102904',
      ],
      status: "blutend");
  WoundEntry entry3 = WoundEntry(
      id: "3woundEntry",
      date: DateTime(2021, 11, 23),
      size: 5.10,
      images: [
        "https://www.heh-bs.de/fileadmin/_processed_/5/0/csm_Chronische_Wunden_eigenes_46562dff92.jpg"
      ],
      status: "blutend");
  return Wound(
      id: "1wound",
      location: "Unterer Rücken",
      type: "Platzwunde",
      isHealed: false,
      startDate: DateTime(2021, 11, 20),
      woundEntrys: [entry, entry2, entry3]);
}

Wound _initWound2() {
  WoundEntry entry = WoundEntry(
      id: "2woundEntry",
      date: DateTime(2021, 12, 12),
      images: [],
      size: 5.10,
      status: "entzündet");
  return Wound(
      id: "2wound",
      location: "Rechter Arm",
      type: "Schürfwunde",
      isHealed: false,
      startDate: DateTime(2021, 12, 12),
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
      phoneNumber: "+49 15204381194",
      firstName: "Peter",
      surname: "Lustig",
      degree: "Dr. med.",
      birthDate: DateTime(1955, 11, 20),
      type: "Lungenfacharzt",
      residence: _initResidence());
}

PatientRecord _initPatientFile() {
  return PatientRecord(
      id: "1patientFile",
      wounds: [_initWound(), _initWound2()],
      attendingDoctor: _initDoctor());
}

Patient _initPatient() {
  return Patient(
    id: "1patient",
    birthDate: DateTime(1937, 11, 01),
    firstName: "Ullricke",
    surname: "Steinbock",
    patientFile: _initPatientFile(),
    residence: _initResidence(),
  );
}

Room _initRoom() {
  return Room(number: 1, name: "Regenbogen Raum", patients: [_initPatient()]);
}

Room _initRoom2() {
  return Room(number: 2, name: "Tennis Raum", patients: [_initPatient()]);
}

Nurse _initNurse() {
  return Nurse(
    id: "1nurse",
    firstName: "Sophie",
    surname: "Splitter",
    birthDate: DateTime(1991, 04, 20),
    residence: _initResidence(),
    phoneNumber: "+49 152137345",
  );
}

OldPeopleHome _initOldPeopleHome() {
  return OldPeopleHome(
      id: "1oldPeopleHome",
      name: "Alte Mensa",
      residence: _initResidence(),
      nurses: [_initNurse()],
      rooms: [_initRoom(), _initRoom2()]);
}

Future<void> initMasterContext(BuildContext context) async {
  globals.masterContext.oldPeopleHomesList.add(_initOldPeopleHome());
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
    initMasterContext(context);
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
  }
}
