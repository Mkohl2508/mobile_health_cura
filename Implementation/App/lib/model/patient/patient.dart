import 'package:cura/model/general/person.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient_file.dart';

class Patient extends Person {
  final Room room;
  final PatientFile patientFile;
  Patient(
      {id,
      name,
      birthDate,
      residence,
      required this.room,
      required this.patientFile})
      : super(id: id, name: name, birthDate: birthDate, residence: residence);
}
