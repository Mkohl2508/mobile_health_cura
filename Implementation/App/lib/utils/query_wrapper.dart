import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/enums/roles.dart';
import 'package:cura/model/general/device.dart';
import 'package:cura/model/general/device_data.dart';
import 'package:cura/model/general/local_user.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import "package:cura/globals.dart" as globals;
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:package_info_plus/package_info_plus.dart';

class QueryWrapper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  static final usersRef = FirebaseFirestore.instance
      .collection("users")
      .withConverter<LocalUser>(
        fromFirestore: (snapshot, _) => LocalUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
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

  static getUser(snapshot) async {
    return await usersRef.doc(snapshot.data!.uid).get().then((value) {
      return value.data();
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

  static postWound(roomId, patientId) async {}

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

  static postWoundEntry(Patient patient, Room room) async {
    // Update the database
    var patiento = patient.patientFile.toJson();
    return await patientsRef(room.number.toString()).doc(patient.id).update({
      "patientFile": {
        "id": patiento["id"],
        "wounds": patiento["wounds"],
        "medication": [{}],
        "attendingDoctor": patiento["attendingDoctor"]?["id"]
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
        .doc(patient.id)
        .set(patient.toJson())
        .catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  static postPatientFile(roomId, patientId, PatientRecord patientFile) async {
    patientsRef(roomId).doc(patientId).update(patientFile.toJson());
    Patient patient = await getPatient(roomId, patientId);
    Room room = await getRoom(roomId);
    for (var element in globals.masterContext.oldPeopleHomesList[0].rooms) {
      if (element.number == room.number) {
        for (var element in element.patients) {
          if (element.id == patient.id) element = patient;
        }
      }
    }
  }

  static Future<Nurse?> postOrUpdateUser(User user) async {
    final _userRef = usersRef.doc(user.uid);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    if ((await _userRef.get()).exists) {
      await _userRef.update({
        "lastLogin": DateTime.fromMillisecondsSinceEpoch(
            user.metadata.lastSignInTime!.millisecondsSinceEpoch),
        "buildNumber": buildNumber,
      });
      return nursesRef
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((value) => value.docs.first.data());
    } else {
      LocalUser userData = LocalUser(
          name: user.displayName!.isEmpty ? user.email : user.displayName,
          email: user.email!,
          lastLogin: DateTime.fromMicrosecondsSinceEpoch(
              user.metadata.lastSignInTime!.microsecondsSinceEpoch),
          creationDate: DateTime.fromMillisecondsSinceEpoch(
              user.metadata.creationTime!.millisecondsSinceEpoch),
          role: Roles.admin,
          buildNumber: buildNumber);
      await _postOrUpdateDevice(user);

      await _userRef.set(userData);

      return nursesRef
          .add(Nurse(userId: user.uid))
          .then((value) => value.get().then((value) => value.data()));
    }
  }

  static Future<Nurse?> getNurseFromUser(user) {
    return nursesRef
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((value) => value.docs.first.data());
  }

  static _postOrUpdateDevice(User user) async {
    Device device = await _initDevice(user);

    final deviceRef =
        usersRef.doc(user.uid).collection("devices").doc(device.deviceId);

    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at": device.updateDate,
        "uninstalled": device.uninstalled,
      });
    } else {
      await deviceRef.set(device.toJson());
    }
  }

  static Future<Device> _initDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    DeviceData deviceData;

    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = DeviceData(
          platform: 'android',
          osVersion: deviceInfo.version.sdkInt.toString(),
          model: deviceInfo.model,
          device: deviceInfo.device);
    } else {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = DeviceData(
          platform: 'ios',
          osVersion: deviceInfo.systemVersion,
          model: deviceInfo.utsname.machine,
          device: deviceInfo.name);
    }

    final nowMS = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().toUtc().millisecondsSinceEpoch);

    return Device(
        deviceId: deviceId,
        creationDate: nowMS,
        updateDate: nowMS,
        uninstalled: false,
        deviceData: deviceData);
  }
}
