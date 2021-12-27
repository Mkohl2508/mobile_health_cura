import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wound.g.dart';

dynamic firestoreDateTimeToJson(dynamic value) => value;

DateTime firestoreDateTimeFromJson(dynamic value) {
  return value != null ? value.toDate() : DateTime.now();
}

@JsonSerializable(explicitToJson: true)
class Wound {
  final String id;
  final String location;
  final String type;
  final bool isHealed;
  @JsonKey(
    toJson: firestoreDateTimeToJson,
    fromJson: firestoreDateTimeFromJson,
  )
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

  String formattedDate() {
    return DateFormat('dd.MM.yyyy').format(startDate);
  }

  factory Wound.fromJson(Map<String, dynamic> json) => _$WoundFromJson(json);

  Map<String, dynamic> toJson() => _$WoundToJson(this);
}
