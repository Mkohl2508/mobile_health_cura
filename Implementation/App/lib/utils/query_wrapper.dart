import 'package:cloud_firestore/cloud_firestore.dart';

class QueryWrapper {
  static const String nursingHomeID = "Uoto3xaa5ZL9N2mMjPhG";

  static getDoctors() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Doctors")
        .get();
    return snapshot.docs;
  }

  static getDoctor(doctorID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Doctors")
        .doc(doctorID)
        .get();
    return snapshot.data();
  }

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

  static getPatient(patientId, roomID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .collection("Patient")
        .doc(patientId)
        .get();
    return snapshot.data();
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

  static Future<dynamic> getRoom(roomID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .get();
    return snapshot.data();
  }

  static getNurses() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Nurses")
        .get();
    return snapshot.docs;
  }

  static getNurse(nurseID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Nurses")
        .doc(nurseID)
        .get();
    return snapshot.data();
  }

  static getNursingHome() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .get();
    return snapshot.data();
  }

  static postWound() async {}

  static postWoundEntry() async {}

  static postDoctor() async {}

  static postResidence() async {}

  static postPatientFile() async {}
}
