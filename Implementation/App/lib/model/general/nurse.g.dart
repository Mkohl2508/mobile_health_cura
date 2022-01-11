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
      role: json['role'] as String?,
    );

Map<String, dynamic> _$NurseToJson(Nurse instance) {
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
  val['residence'] = instance.residence;
  val['phoneNumber'] = instance.phoneNumber;
  val['role'] = instance.role;
  return val;
}
