import 'package:json_annotation/json_annotation.dart';
part 'medication.g.dart';

@JsonSerializable()
class Medication {

    String? id;

  Medication(this.id);

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
