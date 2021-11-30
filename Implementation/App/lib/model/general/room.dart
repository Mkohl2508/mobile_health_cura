// ignore_for_file: file_names

import 'package:cura/model/patient/patient.dart';

class Room {
  final int number;
  final String? name;
  final List<Patient> patients;

  Room({required this.number, this.name, required this.patients});
}
