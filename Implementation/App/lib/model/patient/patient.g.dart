// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'],
      firstName: json['firstName'],
      birthDate: firestoreDateTimeFromJson(json['birthDate']),
      residence: firestoreResidenceFromJson(json['residence']),
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      profilePic: json['profilePic'] as String,
      patientFile:
          PatientRecord.fromJson(json['patientFile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['firstName'] = instance.firstName;
  val['surname'] = instance.surname;
  val['birthDate'] = firestoreDateTimeToJson(instance.birthDate);
  val['residence'] = instance.residence.toJson();
  val['phoneNumber'] = instance.phoneNumber;
  val['patientFile'] = instance.patientFile.toJson();
  val['profilePic'] = instance.profilePic;
  return val;
}
