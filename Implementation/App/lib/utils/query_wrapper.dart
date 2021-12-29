import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryWrapper {
  static const String nursingHomeID = "Uoto3xaa5ZL9N2mMjPhG";

  static getWound() async {}

  static getResidence(residenceID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Residences")
        .doc(residenceID)
        .get()
        .then((value) {
      return value;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static getDoctor(doctorID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Doctors")
        .doc(doctorID)
        .get()
        .then((value) {
      return value;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static getPatientFile() async {}

  static getPatients(roomID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .collection("Patient")
        .get()
        .then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static Future<dynamic> getRooms() async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .get()
        .then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static getNurses() async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Nurses")
        .get()
        .then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static getNursingHome() async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .get()
        .then((value) {
      return value;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  static postWound() async {}

  static postWoundEntry() async {}

  static postDoctor() async {}

  static postResidence() async {}

  static postPatientFile() async {}
}
