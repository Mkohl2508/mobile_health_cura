import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:json_annotation/json_annotation.dart';
part 'patient_record.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRecord {
  static Doctor fromJsonId(dynamic value) {
    return Doctor(
        id: value,
        firstName: "",
        birthDate: DateTime.now(),
        residence: Residence(city: "", street: "", zipCode: "", country: ""),
        surname: "",
        phoneNumber: "",
        degree: "");
  }

  final List<Wound>? wounds;
  final List<Medication>? medications;
  @JsonKey(fromJson: fromJsonId)
  Doctor? attendingDoctor;
  PatientRecord({
    this.wounds,
    this.medications,
    this.attendingDoctor,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) =>
      _$PatientRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRecordToJson(this);
}
