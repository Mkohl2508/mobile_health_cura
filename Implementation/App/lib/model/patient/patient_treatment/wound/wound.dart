import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';

class Wound {
  final String id;
  final String location;
  final String type;
  final bool isHealed;
  final DateTime startDate;
  final List<WoundEntry>? woundEntrys;

  Wound(
      {required this.id,
      required this.location,
      required this.type,
      required this.isHealed,
      required this.startDate,
      List<WoundEntry>? woundEntrys})
      : woundEntrys = woundEntrys ?? [];
}
