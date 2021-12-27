import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryWrapper {
  static const String nursingHomeID = "Uoto3xaa5ZL9N2mMjPhG";

  static getWound() async {}

  static getResidence() async {}

  static getDoctors() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Doctors")
        .get();
    return snapshot.docs;
  }

  static getPatientFile() async {}

  static getPatients(roomID) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .collection("Patient")
        .get();
    return snapshot.docs;
  }

  static Future<dynamic> getRooms() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .get();
    return snapshot.docs;
  }

  static getNurse() async {}

  static getNursingHome() async {}

  static postWound() async {}

  static postWoundEntry() async {}

  static postDoctor() async {}

  static postResidence() async {}

  static postPatientFile() async {}
}
