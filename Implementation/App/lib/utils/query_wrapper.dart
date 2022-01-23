import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/wound_notification.dart';
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
import 'package:uuid/uuid.dart';

/// Static class to provide GET and POST function calls
class QueryWrapper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Id to refer to one retirenment home in the database
  static const String nursingHomeID =
      "gjsrMjy7BzLeWQD844kx"; //"Uoto3xaa5ZL9N2mMjPhG";
  /// Database reference to nursing home
  static final nursingHomeRef = FirebaseFirestore.instance
      .collection('NursingHome')
      .withConverter<OldPeopleHome>(
        fromFirestore: (snapshot, _) =>
            OldPeopleHome.fromJson(snapshot.data()!),
        toFirestore: (oldPeopleHome, _) => oldPeopleHome.toJson(),
      );

  /// Database reference to doctors
  static final doctorsRef = nursingHomeRef
      .doc(nursingHomeID)
      .collection('Doctors')
      .withConverter<Doctor>(
        fromFirestore: (snapshot, _) => Doctor.fromJson(snapshot.data()!),
        toFirestore: (doctor, _) => doctor.toJson(),
      );

  /// Database reference to nurses
  static final nursesRef = nursingHomeRef
      .doc(nursingHomeID)
      .collection('Nurses')
      .withConverter<Nurse>(
        fromFirestore: (snapshot, _) => Nurse.fromJson(snapshot.data()!),
        toFirestore: (nurse, _) => nurse.toJson(),
      );

  /// Database reference to users
  static final usersRef = FirebaseFirestore.instance
      .collection("users")
      .withConverter<LocalUser>(
        fromFirestore: (snapshot, _) => LocalUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  /// Database reference to rooms
  static final roomsRef =
      nursingHomeRef.doc(nursingHomeID).collection('Room').withConverter<Room>(
            fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson(),
          );

  /// Database reference to notifications
  static final notificationsRef =
      nursingHomeRef.doc(nursingHomeID).collection("Notifications").get();

  /// Database reference to patients
  static CollectionReference<Patient> patientsRef(roomId) {
    return roomsRef.doc(roomId).collection("Patient").withConverter<Patient>(
          fromFirestore: (snapshot, _) => Patient.fromJson(snapshot.data()!),
          toFirestore: (patient, _) => patient.toJson(),
        );
  }

  /// Gets a specific user from the database
  static getUser(userUid) async {
    return await usersRef.doc(userUid).get().then((value) {
      return value.data();
    });
  }

  /// Gets all doctors from the database
  static getDoctors() async {
    return await doctorsRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Gets a specific doctor from the database
  static getDoctor(doctorID) async {
    return await doctorsRef.doc(doctorID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Gets all notifications from the database and adds the ids
  static Future<List<WoundNotification>> getNotifications() async {
    var notifications = await notificationsRef;
    List<WoundNotification> woundNotifications = [];
    for (var notification in notifications.docs) {
      var notificationJSON = notification.data();
      notificationJSON["id"] = notification.id;
      woundNotifications.add(WoundNotification.fromJson(notificationJSON));
    }
    return woundNotifications;
  }

  /// Gets all patients from the database in a given room
  static getPatients(roomID) async {
    return await patientsRef(roomID).get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  /// Gets a specific patient from the database
  static getPatient(patientId, roomID) async {
    return await patientsRef(roomID).doc(patientId).get().then((value) {
      return value.data();
    }).catchError((Object e) {
      print('Got error: $e'); // Finally, callback fires.
      return null; // Future completes with 42.
    });
  }

  /// Gets all rooms from the database
  static Future<dynamic> getRooms() async {
    return await roomsRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error: $e'); // Finally, callback fires.
      return 42; // Future completes with 42.
    });
  }

  /// Gets a specific room from the database
  static Future<dynamic> getRoom(roomID) async {
    return await roomsRef.doc(roomID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Gets all nurses from the database
  static getNurses() async {
    return await nursesRef.get().then((value) {
      return value.docs;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Gets a specific nurse from the database
  static getNurse(nurseID) async {
    return await nursesRef.doc(nurseID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Gets currently selected nursing home
  static getNursingHome() async {
    return await nursingHomeRef.doc(nursingHomeID).get().then((value) {
      return value.data();
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Uploads image to firebase storage
  static Future<String> uploadImage(File img, String path) async {
    final _storage = FirebaseStorage.instance;

    // Upload image and receive image URL
    var snapshot = await _storage.ref().child(path).putFile(img);
    var downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  /// Uploads a list of images to Firebase storage
  static Future<List<String>> uploadImageList(
      List<File> images, String path) async {
    List<String> imagesURL = [];
    for (var i = 0; i < images.length; i++) {
      imagesURL.add(await uploadImage(images[i], path + i.toString()));
    }

    return imagesURL;
  }

  /// Updates the status and nurse for a notification
  static postNotification(
      String notificationID, String status, String nurseID) async {
    return await nursingHomeRef
        .doc(nursingHomeID)
        .collection("Notifications")
        .doc(notificationID)
        .update({"status": status, "nurseId": nurseID}).then((value) {
      return value;
    }).catchError((e) {
      print('Got error:$e');
      return 42;
    });
  }

  /// Updates the entire patientfile of a patient
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

  /// Adds a new doctor to the database
  static postDoctor(Doctor doctor) async {
    await doctorsRef.add(doctor).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].doctors.add(doctor);
  }

  /// Adds a new nurse to the database
  static postNurse(Nurse nurse) async {
    await nursesRef.add(nurse).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].nurses.add(nurse);
  }

  /// Adds a new room to the database with custom ID
  static postRoom(Room room) async {
    await roomsRef.doc(room.number.toString()).set(room).catchError((e) {
      print('Got error:$e');
      return 42;
    });
    globals.masterContext.oldPeopleHomesList[0].rooms.add(room);
  }

  /// Adds a new patient to the database with custom ID
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

  /// Adds a new patientsfile to a patient the database with custom ID
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

  /// Adds or updates a user in the database
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
      String id = Uuid().v1();
      Nurse newNurse = Nurse(
          id: id,
          firstName: "",
          surname: "",
          birthDate: DateTime.now(),
          residence: "",
          phoneNumber: "",
          profileImage: "",
          userId: user.uid);
      nursesRef.doc(Uuid().v1()).set(newNurse).then((value) => newNurse);
    }
  }

  /// Gets the Nurse that is connected to a user object
  static Future<Nurse?> getNurseFromUser(user) {
    return nursesRef
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((value) => value.docs.first.data());
  }

  /// Adds or updates a device to the database
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

  /// initializes a device
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
