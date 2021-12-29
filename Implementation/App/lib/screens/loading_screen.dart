import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import "package:cura/globals.dart" as globals;
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
    Map<String, dynamic> doctorData = await QueryWrapper.getDoctor(doctorId.id);
    Doctor doctor = Doctor.fromJson(doctorData);

    doctors.add(doctor);
  }
  return doctors;
}

Future<List<Patient>> _initPatient(roomID, doctors) async {
  List<Patient> initPatients = [];
  List<dynamic> patientsIds = await QueryWrapper.getPatients(roomID);
  for (var patientId in patientsIds) {
    Map<String, dynamic> patientData =
        await QueryWrapper.getPatient(patientId.id, roomID);
    Patient patient = Patient.fromJson(patientData);
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
    Map<String, dynamic> roomData = await QueryWrapper.getRoom(roomId.id);
    Room room = Room.fromJson(roomData);

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
    Map<String, dynamic> nurseData = await QueryWrapper.getNurse(nurseId.id);
    Nurse nurse = Nurse.fromJson(nurseData);

    nurses.add(nurse);
  }
  return nurses;
}

Future<OldPeopleHome> _initOldPeopleHome() async {
  Map<String, dynamic> oldPeopleHomeData = await QueryWrapper.getNursingHome();
  OldPeopleHome oldPeopleHome = OldPeopleHome.fromJson(oldPeopleHomeData);
  List<Doctor> doctors = await _initDoctors();
  return OldPeopleHome(
      id: oldPeopleHome.id,
      name: oldPeopleHome.name,
      doctors: doctors,
      nurses: await _initNurses(),
      rooms: await _initRooms(doctors),
      residence: oldPeopleHome.residence);
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
