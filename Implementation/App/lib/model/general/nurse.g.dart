// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nurse _$NurseFromJson(Map<String, dynamic> json) => Nurse(
      id: json['id'],
      firstName: json['firstName'],
      surname: json['surname'],
      birthDate: firestoreDateTimeFromJson(json['birthDate']),
      residence: firestoreResidenceFromJson(json['residence']),
      phoneNumber: json['phoneNumber'],
      userId: json['userId'] as String,
    );
