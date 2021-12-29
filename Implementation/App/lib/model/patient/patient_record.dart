import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:json_annotation/json_annotation.dart';
part 'patient_record.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRecord {
  final String id;
  final List<Wound>? wounds;
  final List<Medication>? medications;
  final Doctor? attendingDoctor;
  PatientRecord({
    required this.id,
    this.wounds,
    this.medications,
    this.attendingDoctor,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordToJson(this);
}
