import 'package:cura/model/general/person.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:json_annotation/json_annotation.dart';
part 'patient.g.dart';

@JsonSerializable(explicitToJson: true)
class Patient extends Person {
  final PatientRecord patientFile;
  final String roomId;

  Patient(
      {id,
      required firstName,
      required birthDate,
      required residence,
      required surname,
      required phoneNumber,
      required this.patientFile,
      required this.roomId})
      : super(
            id: id,
            firstName: firstName,
            birthDate: birthDate,
            residence: residence,
            surname: surname,
            phoneNumber: phoneNumber);

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
