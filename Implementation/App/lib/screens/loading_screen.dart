import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/screens/home_screen.dart';
import 'package:cura/utils/query_wrapper.dart';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
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
    PatientRecord patientRecord = await
        addDoctorToPatientRecord(patient, doctors);

    initPatients.add(finalPatient(patient, patientRecord));
  }
  return initPatients;
}

Future<PatientRecord> addDoctorToPatientRecord(Patient patient, doctors)async {
  return PatientRecord(
      wounds: await _initWounds(patient),
      medications:await _initMedications(patient),
      attendingDoctor:
          findAttentingDoctor(patient.patientFile.attendingDoctor!.id, doctors));
}

Future<List<Wound>> _initWounds(Patient patient)async {
List<Wound> initWounds = [];
  List<dynamic> woundsIds = await QueryWrapper.getPatientWounds(patient);
  for (var woundId in woundsIds) {
    Wound wound = await QueryWrapper.getWound(patient, woundId.id);
    initWounds.add(wound);
  }
  return initWounds;
}

Future<List<Medication>> _initMedications(Patient patient) async{
  List<Medication> initMedications = [];
  List<dynamic> MedicationsIds = await QueryWrapper.getPatientMedications(patient);
  for (var medicationId in MedicationsIds) {
    Medication medication = await QueryWrapper.getMedication(patient, medicationId.id);
    initMedications.add(medication);
  }
  return initMedications;
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
      profilePic: patient.profilePic,
      firstName: patient.firstName,
      birthDate: patient.birthDate,
      residence: patient.residence,
      surname: patient.surname,
      phoneNumber: patient.phoneNumber,
      roomId: patient.roomId,
      patientFile: patientRecord);
}

Future<List<Room>> _initRooms(doctors) async {
  List<Room> initRooms = [];
  List<dynamic> rooms = await QueryWrapper.getRooms();
  for (var roomId in rooms) {
    Room room = await QueryWrapper.getRoom(roomId.id);
    initRooms.add(Room(
        id: room.id,
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
