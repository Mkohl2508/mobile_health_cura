import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryWrapper {
  static final String NursingHome_ID = "Uoto3xaa5ZL9N2mMjPhG";

  static getWound() async {}

  static getResidence() async {}

  static getDoctor() async {}

  static getPatientFile() async {}

  static getPatient() async {}

  static Future<dynamic> getRooms() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(NursingHome_ID)
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
