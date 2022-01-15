// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientRecord _$PatientRecordFromJson(Map<String, dynamic> json) =>
    PatientRecord(
      attendingDoctor: PatientRecord.fromJsonId(json['attendingDoctor']),
    );

Map<String, dynamic> _$PatientRecordToJson(PatientRecord instance) =>
    <String, dynamic>{
      'attendingDoctor': instance.attendingDoctor?.toJson(),
    };
