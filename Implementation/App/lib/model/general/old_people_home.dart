import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:json_annotation/json_annotation.dart';
part 'old_people_home.g.dart';

@JsonSerializable(explicitToJson: true)
class OldPeopleHome {
  final String id;
  final String name;
  final List<Room> rooms;
  final List<Nurse> nurses;
  final Residence residence;

  OldPeopleHome({
    required this.id,
    required this.name,
    required this.rooms,
    required this.nurses,
    required this.residence,
  });

  factory OldPeopleHome.fromJson(Map<String, dynamic> json) =>
      _$OldPeopleHomeFromJson(json);

  Map<String, dynamic> toJson() => _$OldPeopleHomeToJson(this);
}
