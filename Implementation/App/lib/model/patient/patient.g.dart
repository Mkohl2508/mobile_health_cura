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

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'birthDate': firestoreDateTimeToJson(instance.birthDate),
      'residence': instance.residence.toJson(),
      'phoneNumber': instance.phoneNumber,
      'patientFile': instance.patientFile.toJson(),
      'profilePic': instance.profilePic,
    };
