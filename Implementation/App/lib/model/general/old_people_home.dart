import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/residence/residence.dart';

class OldPeopleHome {
  final String id;
  final String name;
  final List<Patient> patients;
  final List<Nurse> nurses;
  final Residence residence;

  OldPeopleHome({
    required this.id,
    required this.name,
    required this.patients,
    required this.nurses,
    required this.residence,
  });
}
