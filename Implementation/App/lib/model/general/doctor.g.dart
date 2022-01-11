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

Map<String, dynamic> _$DoctorToJson(Doctor instance) {
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
  val['degree'] = instance.degree;
  val['type'] = instance.type;
  return val;
}
