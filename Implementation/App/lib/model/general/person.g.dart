// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String?,
      firstName: json['firstName'] as String,
      surname: json['surname'] as String,
      birthDate: firestoreDateTimeFromJson(json['birthDate']),
      residence: firestoreResidenceFromJson(json['residence']),
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) {
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
  return val;
}
