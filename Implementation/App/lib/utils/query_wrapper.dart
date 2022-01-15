import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/patient/patient_record.dart';
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

class QueryWrapper {
  static const String nursingHomeID =
      "Uoto3xaa5ZL9N2mMjPhG"; //"Uoto3xaa5ZL9N2mMjPhG";

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

  static CollectionReference<Wound> woundRef(patient) {
    return patientsRef(patient.roomId)
        .doc(patient.id)
        .collection('Wounds')
        .withConverter<Wound>(
          fromFirestore: (snapshot, _) => Wound.fromJson(snapshot.data()!),
          toFirestore: (wound, _) => wound.toJson(),
        );
  }

  static CollectionReference<Medication> medicationRef(patient) {
    return patientsRef(patient.roomId)
        .doc(patient.id)
        .collection('Medications')
        .withConverter<Medication>(
          fromFirestore: (snapshot, _) => Medication.fromJson(snapshot.data()!),
          toFirestore: (medication, _) => medication.toJson(),
        );
  }

  static getPatientWounds(Patient patient) async {
    return await woundRef(patient).get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getWound(Patient patient, woundId) async {
    return await woundRef(patient).doc(woundId).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getMedication(Patient patient, woundId) async {
    return await medicationRef(patient).doc(woundId).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getPatientMedications(Patient patient) async {
    return await medicationRef(patient).get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
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

  static Future<String> uploadImage(File img, String path) async {
    final _storage = FirebaseStorage.instance;

    // Upload image and receive image URL
    var snapshot = await _storage.ref().child(path).putFile(img);
    var downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<List<String>> uploadImageList(
      List<File> images, String path) async {
    List<String> imagesURL = [];
    for (var i = 0; i < images.length; i++) {
      imagesURL.add(await uploadImage(images[i], path + i.toString()));
    }

    return imagesURL;
  }

  static Future postWoundEntry(
      Patient patient, Wound wound, WoundEntry entry) async {
    return woundRef(patient).doc(wound.id).update({
      'woundEntrys': FieldValue.arrayUnion([entry.toJson()])
    }).then((value) => {
          globals.masterContext.oldPeopleHomesList[0].rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .wounds!
              .firstWhere((element) => element.id == wound.id)
              .woundEntrys!
              .add(entry)
        });
  }

  static Future postDoctor(Doctor doctor) async {
    DocumentReference<Doctor> addedDoctor = await doctorsRef.add(doctor);
    return addedDoctor.update({'id': addedDoctor.id}).then((value) => {
          doctor.id = addedDoctor.id,
          globals.masterContext.getById(nursingHomeID)!.doctors.add(doctor)
        });
  }

  static Future postNurse(Nurse nurse) async {
    DocumentReference<Nurse> addedNurse = await nursesRef.add(nurse);
    return addedNurse.update({'id': addedNurse.id}).then((value) => {
          nurse.id = addedNurse.id,
          globals.masterContext.getById(nursingHomeID)!.nurses.add(nurse)
        });
  }

  static Future postRoom(Room room) async {
    DocumentReference<Room> addedRoom = await roomsRef.add(room);
    return addedRoom.update({'id': addedRoom.id}).then((value) => {
          room.id = addedRoom.id,
          globals.masterContext.getById(nursingHomeID)!.rooms.add(room)
        });
  }

  static Future postPatient(Patient patient) async {
    DocumentReference<Patient> addedPatient =
        await patientsRef(patient.roomId).add(patient);
    return addedPatient.update({'id': addedPatient.id}).then((value) => {
          patient.id = addedPatient.id,
          globals.masterContext
              .getById(nursingHomeID)!
              .rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .add(patient)
        });
  }

  static Future postAttendingDoctor(Doctor doctor, Patient patient) async {
    return patientsRef(patient.roomId)
        .doc(patient.id)
        .update({'patientFile.attendingDoctor': doctor.id}).then(
            (value) => {_getPatientFile(patient).attendingDoctor = doctor});
  }

  static Future postMedication(Medication medication, Patient patient) async {
    DocumentReference<Medication> addedMedication =
        await medicationRef(patient).add(medication);
    return addedMedication.update({'id': addedMedication.id}).then((value) => {
          medication.id = addedMedication.id,
          globals.masterContext
              .getById(nursingHomeID)!
              .rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .medications!
              .add(medication)
        });
  }

  static Future postWound(Patient patient, Wound wound) async {
    DocumentReference<Wound> addedWound = await woundRef(patient).add(wound);
    return addedWound.update({'id': addedWound.id}).then((value) => {
          wound.id = addedWound.id,
          globals.masterContext
              .getById(nursingHomeID)!
              .rooms
              .firstWhere((element) => element.id == patient.roomId)
              .patients!
              .firstWhere((element) => element.id == patient.id)
              .patientFile
              .wounds!
              .add(wound)
        });
  }

  static PatientRecord _getPatientFile(Patient patient) {
    return globals.masterContext
        .getById(nursingHomeID)!
        .rooms
        .firstWhere((element) => element.id == patient.roomId)
        .patients!
        .firstWhere((element) => element.id == patient.id)
        .patientFile;
  }
}
