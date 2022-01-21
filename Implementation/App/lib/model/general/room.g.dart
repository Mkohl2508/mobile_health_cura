// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      number: json['number'] as int,
      name: json['name'] as String?,
      patients: Room.emptyPatients(json['patients']),
    );

Map<String, dynamic> _$RoomToJson(Room instance) {
  final val = <String, dynamic>{
    'number': instance.number,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('patients', Room.toNull(instance.patients));
  return val;
}
