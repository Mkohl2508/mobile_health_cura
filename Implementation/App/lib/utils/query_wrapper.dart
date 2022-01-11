import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';

class QueryWrapper {
  static const String nursingHomeID = "Uoto3xaa5ZL9N2mMjPhG";

  static final nursingHomeRef = FirebaseFirestore.instance
      .collection('NursingHome')
      .withConverter<OldPeopleHome>(
        fromFirestore: (snapshot, _) =>
            OldPeopleHome.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  static final doctorsRef = nursingHomeRef
      .doc(nursingHomeID)
      .collection('Doctors')
      .withConverter<Doctor>(
        fromFirestore: (snapshot, _) => Doctor.fromJson(snapshot.data()!),
        toFirestore: (doctor, _) => doctor.toJson(),
      );

  static final nursesRef = nursingHomeRef
      .doc(nursingHomeID)
      .collection('Nurses')
      .withConverter<Nurse>(
        fromFirestore: (snapshot, _) => Nurse.fromJson(snapshot.data()!),
        toFirestore: (nurse, _) => nurse.toJson(),
      );

  static final roomsRef =
      nursingHomeRef.doc(nursingHomeID).collection('Room').withConverter<Room>(
            fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson(),
          );

  static CollectionReference<Patient> patientsRef(roomId) {
    return roomsRef.doc(roomId).collection("Patient").withConverter<Patient>(
          fromFirestore: (snapshot, _) => Patient.fromJson(snapshot.data()!),
          toFirestore: (patient, _) => patient.toJson(),
        );
  }

  static getDoctors() async {
    return await doctorsRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getDoctor(doctorID) async {
    return await doctorsRef.doc(doctorID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getPatients(roomID) async {
    return await patientsRef(roomID).get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static getPatient(patientId, roomID) async {
    return await patientsRef(roomID).doc(patientId).get().then((value) {
      return value.data();
    }).catchError((Object e) {
      print('Got error: $e'); // Finally, callback fires.
      return null; // Future completes with 42.
    });
  }

  static Future<dynamic> getRooms() async {
    return await roomsRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static Future<dynamic> getRoom(roomID) async {
    return await roomsRef.doc(roomID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getNurses() async {
    return await nursesRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getNurse(nurseID) async {
    return await nursesRef.doc(nurseID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getNursingHome() async {
    return await nursingHomeRef.doc(nursingHomeID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static postDoctor(Doctor doctor) async {
    DocumentReference<Doctor> addedDoctor = await doctorsRef.add(doctor);
    addedDoctor.update({'id': addedDoctor.id}).then((value) => {
          doctor.id = addedDoctor.id,
          globals.masterContext.oldPeopleHomesList[0].doctors.add(doctor)
        });
  }

  static postNurse(Nurse nurse) async {
    DocumentReference<Nurse> addedNurse = await nursesRef.add(nurse);
    addedNurse.update({'id': addedNurse.id}).then((value) => {
          nurse.id = addedNurse.id,
          globals.masterContext.oldPeopleHomesList[0].nurses.add(nurse)
        });
  }

  static Future postRoom(Room room) async {
    DocumentReference<Room> addedRoom = await roomsRef.add(room);
    addedRoom.update({'id': addedRoom.id}).then((value) => {
          room.id = addedRoom.id,
          globals.masterContext.oldPeopleHomesList[0].rooms.add(room)
        });
  }

  static Future postPatient(Patient patient) async {
    DocumentReference<Patient> addedPatient =
        await patientsRef(patient.roomId).add(patient);
    return addedPatient.update({'id': addedPatient.id}).then((value) => {
          patient.id = addedPatient.id,
          globals.masterContext.oldPeopleHomesList[0].rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .add(patient)
        });
  }

  static postAttendingDoctor(Doctor doctor, Patient patient) async {
    patientsRef(patient.roomId).doc(patient.id).update({
      'patientFile': {'attendingDoctor': doctor.id}
    }).then((value) => {
          globals.masterContext.oldPeopleHomesList[0].rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .attendingDoctor = doctor
        });
  }

  static postMedication(Medication medication, Patient patient) async {
    patientsRef(patient.roomId).doc(patient.id).update({
      'patientFile': {
        'medications': FieldValue.arrayUnion([medication])
      }
    }).then((value) => {
          globals.masterContext.oldPeopleHomesList[0].rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .medications!
              .add(medication)
        });
  }

  static postWound(Patient patient, Wound wound) async {
    patientsRef(patient.roomId).doc(patient.id).update({
      'patientFile': {
        'wounds': FieldValue.arrayUnion([wound])
      }
    }).then((value) => {
          globals.masterContext.oldPeopleHomesList[0].rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .wounds!
              .add(wound)
        });
  }

  static postWoundEntry(File img, Patient patient, Room room, String woundIndex,
      WoundEntry woundEntry) async {
    final _storage = FirebaseStorage.instance;

    // Upload image and receive image URL
    var snapshot = await _storage
        .ref()
        .child(
            "${patient.surname}_${patient.firstName}/$woundIndex/${woundEntry.id.toString()}/${woundEntry.images.length.toString()}")
        .putFile(img);
    var downloadURL = await snapshot.ref.getDownloadURL();

    // Get wound entry and add the image URL to local model
    Wound wound = patient.patientFile.wounds!
        .firstWhere((element) => element.id == woundIndex);
    wound
        .getWoundEntries()!
        .firstWhere((element) => element.id == woundEntry.id)
        .add(downloadURL);

    // Update the database
    var patiento = patient.patientFile.toJson();
    return await patientsRef(room.number.toString()).doc(patient.id).update({
      "patientFile": {
        "id": patiento["id"],
        "wounds": patiento["wounds"],
        "medication": [{}],
        "attendingDoctor": patiento["attendingDoctor"]["id"]
      }
    }).then((value) {
      return value;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }
}
