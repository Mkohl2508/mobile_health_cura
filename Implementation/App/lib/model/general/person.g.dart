// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
      birthDate: firestoreDateTimeFromJson(json['birthDate']),
      residence: firestoreResidenceFromJson(json['residence']),
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'birthDate': firestoreDateTimeToJson(instance.birthDate),
      'residence': firestoreResidenceToJson(instance.residence),
      'phoneNumber': instance.phoneNumber,
    };
