import 'package:cura/model/general/person.dart';
import 'package:cura/model/patient/patient_record.dart';

class Patient extends Person {
  final PatientRecord patientFile;
  Patient(
      {required id,
      required firstName,
      required birthDate,
      required residence,
      required surname,
      required this.patientFile})
      : super(
            id: id,
            firstName: firstName,
            birthDate: birthDate,
            residence: residence,
            surname: surname);
}
