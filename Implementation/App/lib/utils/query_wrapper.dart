import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

class QueryWrapper {
  static const String nursingHomeID =
      "gjsrMjy7BzLeWQD844kx"; //"Uoto3xaa5ZL9N2mMjPhG";

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

  static postWound(roomId, patientId) async {}

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

  static postDoctor(Doctor doctor) async {
    await doctorsRef.add(doctor).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].doctors.add(doctor);
  }

  static postNurse(Nurse nurse) async {
    await nursesRef.add(nurse).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].nurses.add(nurse);
  }

  static postRoom(Room room) async {
    await roomsRef.doc(room.number.toString()).set(room).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].rooms.add(room);
  }

  static postPatient(roomId, Patient patient) async {
    roomsRef
        .doc(roomId)
        .collection('Patient')
        .add(patient.toJson())
        .catchError((e) {
      print('Got error:$e');
      return 42;
    });
    Room room = await getRoom(roomId);
    for (var element in globals.masterContext.oldPeopleHomesList[0].rooms) {
      if (element.number == room.number) element.patients!.add(patient);
    }
  }

  static postPatientFile(roomId, patientId, PatientRecord patientFile) async {
    patientsRef(roomId).doc(patientId).update(patientFile.toJson());
    Patient patient = await getPatient(roomId, patientId);
    Room room = await getRoom(roomId);
    for (var element in globals.masterContext.oldPeopleHomesList[0].rooms) {
      if (element.number == room.number) {
        for (var element in element.patients!) {
          if (element.id == patient.id) element = patient;
        }
      }
    }
  }
}
