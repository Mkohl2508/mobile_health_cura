import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'patient_record.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientRecord {
  static Doctor fromJsonId(dynamic value) {
    return Doctor(
        id: value ?? Uuid().v1(),
        firstName: "",
        birthDate: DateTime.now(),
        residence:
            Residence(id: "", city: "", street: "", zipCode: "", country: ""),
        surname: "",
        phoneNumber: "",
        degree: "");
  }

  final String id;
  final List<Wound>? wounds;
  final List<Medication>? medications;
  @JsonKey(fromJson: fromJsonId)
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
