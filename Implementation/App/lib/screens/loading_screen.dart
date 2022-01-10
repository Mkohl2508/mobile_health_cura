import 'package:cura/model/enums/edge_enum.dart';
import 'package:cura/model/enums/exudate_enum.dart';
import 'package:cura/model/enums/form_enum.dart';
import 'package:cura/model/enums/phase_enum.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
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
      edge: EdgeEnum.defined,
      exudate: ExudateEnum.serosanguinous,
      isOpen: true,
      isSmelly: false,
      phase: PhaseEnum.hemostasis,
      size: 5.10,
      images: [
        "https://www.haeusliche-pflege.net/-/media/ahi/alle-netzwerke/digital/produkte-digital/elearning/0038_Expertenstandard-Pflege-von-Menschen-mit-chronischen-Wunden.png?bc=White&as=0&w=1000&hash=12DFA01B2A8FD46990BB13A311A3DE7C"
      ],
      status: "blutend");
  WoundEntry entry2 = WoundEntry(
      id: "2woundEntry",
      edge: EdgeEnum.defined,
      exudate: ExudateEnum.serosanguinous,
      isOpen: true,
      isSmelly: false,
      phase: PhaseEnum.hemostasis,
      date: DateTime(2021, 11, 18),
      size: 5.10,
      images: [
        'https://www.draco.de/fileadmin/_processed_/4/3/csm_chronische-wunde_2313ccd551.jpg',
        'https://www.hartmann.info/-/media/wound/img/homesite-wunde_teaser_ulcus-cruris-venosum_phi21_02_03.png?h=270&iar=0&mw=868&w=525&rev=79ba654e383d4e8ba3006f3d8f7f481a&sc_lang=de-de&hash=D943076C221F102F181352CCE6102904',
      ],
      status: "blutend");
  WoundEntry entry3 = WoundEntry(
      edge: EdgeEnum.defined,
      exudate: ExudateEnum.serosanguinous,
      isOpen: true,
      isSmelly: false,
      phase: PhaseEnum.inflammatory,
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
      form: FormEnum.ellipse,
      isChronic: false,
      startDate: DateTime(2021, 11, 20),
      woundEntrys: [entry, entry2, entry3]);
}

Wound _initWound2() {
  return Wound(
      id: "2wound",
      location: "Rechter Arm",
      type: "Schürfwunde",
      isHealed: false,
      startDate: DateTime(2021, 12, 12),
      form: FormEnum.ellipse,
      isChronic: false,
      woundEntrys: []);
}

Future<List<Doctor>> _initDoctors() async {
  List<Doctor> doctors = [];
  List<dynamic> doctorsIds = await QueryWrapper.getDoctors();
  for (var doctorId in doctorsIds) {
    Doctor doctor = await QueryWrapper.getDoctor(doctorId.id);
    doctors.add(doctor);
  }
  return doctors;
}

Future<List<Patient>> _initPatient(roomID, doctors) async {
  List<Patient> initPatients = [];
  List<dynamic> patientsIds = await QueryWrapper.getPatients(roomID);
  for (var patientId in patientsIds) {
    Patient patient = await QueryWrapper.getPatient(patientId.id, roomID);
    PatientRecord patientRecord =
        addDoctorToPatientRecord(patient.patientFile, doctors);

    initPatients.add(finalPatient(patient, patientRecord));
  }
  return initPatients;
}

PatientRecord addDoctorToPatientRecord(patientFile, doctors) {
  return PatientRecord(
      id: patientFile.id,
      wounds: patientFile.wounds,
      medications: patientFile.medications,
      attendingDoctor:
          findAttentingDoctor(patientFile.attendingDoctor!.id, doctors));
}

Doctor? findAttentingDoctor(doctorId, doctors) {
  for (var doctor in doctors) {
    if (doctor.id == doctorId) {
      return doctor;
    }
  }
}

Patient finalPatient(patient, patientRecord) {
  return Patient(
      id: patient.id,
      firstName: patient.firstName,
      birthDate: patient.birthDate,
      residence: patient.residence,
      surname: patient.surname,
      phoneNumber: patient.phoneNumber,
      patientFile: patientRecord);
}

Future<List<Room>> _initRooms(doctors) async {
  List<Room> initRooms = [];
  List<dynamic> rooms = await QueryWrapper.getRooms();
  for (var roomId in rooms) {
    Room room = await QueryWrapper.getRoom(roomId.id);
    initRooms.add(Room(
        number: room.number,
        name: room.name,
        patients: await _initPatient(roomId.id, doctors)));
  }
  return initRooms;
}

Future<List<Nurse>> _initNurses() async {
  List<Nurse> nurses = [];
  List<dynamic> nursesIds = await QueryWrapper.getNurses();
  for (var nurseId in nursesIds) {
    Nurse nurse = await QueryWrapper.getNurse(nurseId.id);
    nurses.add(nurse);
  }
  return nurses;
}

Future<OldPeopleHome> _initOldPeopleHome() async {
  OldPeopleHome oldPeopleHome = await QueryWrapper.getNursingHome();
  List<Doctor> doctors = await _initDoctors();
  return OldPeopleHome(
      id: oldPeopleHome.id,
      name: oldPeopleHome.name,
      doctors: doctors,
      nurses: await _initNurses(),
      rooms: await _initRooms(doctors),
      residence: oldPeopleHome.residence);
}

Future<OldPeopleHome> initMasterContext() async {
  return await _initOldPeopleHome();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    // init mock data
    return Scaffold(
      body: Center(
        child: FutureBuilder<OldPeopleHome>(
            future: initMasterContext(),
            builder:
                (BuildContext context, AsyncSnapshot<OldPeopleHome> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  globals.masterContext.oldPeopleHomesList.add(snapshot.data!);
                }
                return HomeScreen();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      CircularProgressIndicator(),
                      Text("Loading..."),
                    ]));
              } else if (snapshot.hasError) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Error: " + snapshot.error.toString()),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadingScreen()));
                          },
                          icon: Icon(Icons.update))
                    ]);
              } else {
                return Text("Error");
              }
            }),
      ),
    );
  }
}
