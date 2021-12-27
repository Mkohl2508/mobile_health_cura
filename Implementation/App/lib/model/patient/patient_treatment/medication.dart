import 'package:json_annotation/json_annotation.dart';
part 'medication.g.dart';

@JsonSerializable()
class Medication {
  Medication();

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
