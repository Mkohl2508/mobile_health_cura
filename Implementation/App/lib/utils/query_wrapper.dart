import 'package:cloud_firestore/cloud_firestore.dart';

class QueryWrapper {
  static const String nursingHomeID = "Uoto3xaa5ZL9N2mMjPhG";

  static getDoctors() async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Doctors")
        .get()
        .then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
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
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

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

  static getPatient(patientId, roomID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .collection("Patient")
        .doc(patientId)
        .get()
        .then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
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

  static Future<dynamic> getRoom(roomID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Room")
        .doc(roomID)
        .get()
        .then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
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
      print('Got error:$e');
      return 42;
    });
  }

  static getNurse(nurseID) async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .collection("Nurses")
        .doc(nurseID)
        .get()
        .then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static getNursingHome() async {
    return await FirebaseFirestore.instance
        .collection("NursingHome")
        .doc(nursingHomeID)
        .get()
        .then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static postWound() async {}

  static postWoundEntry() async {}

  static postDoctor() async {}

  static postResidence() async {}

  static postPatientFile() async {}
}
