import 'package:cura/model/general/person.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient_file.dart';

class Patient extends Person {
  final Room room;
  final PatientFile patientFile;
  Patient(
      {required id,
      required firstName,
      required birthDate,
      required residence,
      required surname,
      required this.room,
      required this.patientFile})
      : super(
            id: id,
            firstName: firstName,
            birthDate: birthDate,
            residence: residence,
            surname: surname);
}
