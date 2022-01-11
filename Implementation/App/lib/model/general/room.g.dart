// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      number: json['number'] as int,
      name: json['name'] as String?,
      patients: [],
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
    };
