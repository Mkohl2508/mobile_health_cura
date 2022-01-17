import 'package:cura/model/patient/patient.dart';
import 'package:json_annotation/json_annotation.dart';
part 'room.g.dart';

@JsonSerializable(explicitToJson: true)
class Room {
  static List<Patient> emptyPatients(dynamic value) => <Patient>[];

  final int number;
  final String? name;
  final List<Patient> patients;

  Room({required this.number, this.name, required this.patients});

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
