// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_people_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OldPeopleHome _$OldPeopleHomeFromJson(Map<String, dynamic> json) =>
    OldPeopleHome(
      id: json['id'] as String,
      name: json['name'] as String,
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
      nurses: (json['nurses'] as List<dynamic>)
          .map((e) => Nurse.fromJson(e as Map<String, dynamic>))
          .toList(),
      residence: Residence.fromJson(json['residence'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OldPeopleHomeToJson(OldPeopleHome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rooms': instance.rooms.map((e) => e.toJson()).toList(),
      'nurses': instance.nurses.map((e) => e.toJson()).toList(),
      'residence': instance.residence.toJson(),
    };
