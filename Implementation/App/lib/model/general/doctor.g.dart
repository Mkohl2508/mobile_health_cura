// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      id: json['id'],
      firstName: json['firstName'],
      birthDate: firestoreDateTimeFromJson(json['birthDate']),
      residence: firestoreResidenceFromJson(json['residence']),
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      type: json['type'] as String?,
      degree: json['degree'] as String,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'birthDate': firestoreDateTimeToJson(instance.birthDate),
      'residence': instance.residence.toJson(),
      'phoneNumber': instance.phoneNumber,
      'degree': instance.degree,
      'type': instance.type,
    };
