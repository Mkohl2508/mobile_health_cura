import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/patient/patient_treatment/medication.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';

class PatientFile {
  final String id;
  final List<Wound>? wounds;
  final List<Medication>? medications;
  final Doctor? attendingDoctor;

  PatientFile({
    required this.id,
    this.wounds,
    this.medications,
    this.attendingDoctor,
  });
}
