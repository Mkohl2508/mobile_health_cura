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
      profileImage: json['profileImage'] as String?,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$NurseToJson(Nurse instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'birthDate': firestoreDateTimeToJson(instance.birthDate),
      'residence': instance.residence,
      'phoneNumber': instance.phoneNumber,
      'userId': instance.userId,
      'profileImage': instance.profileImage,
    };
