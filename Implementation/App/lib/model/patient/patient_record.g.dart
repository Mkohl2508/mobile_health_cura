// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientRecord _$PatientRecordFromJson(Map<String, dynamic> json) =>
    PatientRecord(
      wounds: (json['wounds'] as List<dynamic>?)
          ?.map((e) => Wound.fromJson(e as Map<String, dynamic>))
          .toList(),
      medications: (json['medications'] as List<dynamic>?)
          ?.map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendingDoctor: PatientRecord.fromJsonId(json['attendingDoctor']),
    );

Map<String, dynamic> _$PatientRecordToJson(PatientRecord instance) =>
    <String, dynamic>{
      'wounds': instance.wounds?.map((e) => e.toJson()).toList(),
      'medications': instance.medications?.map((e) => e.toJson()).toList(),
      'attendingDoctor': instance.attendingDoctor?.toJson(),
    };
