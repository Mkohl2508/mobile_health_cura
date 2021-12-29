// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_people_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OldPeopleHome _$OldPeopleHomeFromJson(Map<String, dynamic> json) =>
    OldPeopleHome(
      id: json['id'] as String,
      name: json['name'] as String,
      rooms: OldPeopleHome.emptyRooms(json['rooms']),
      nurses: OldPeopleHome.emptyNurses(json['nurses']),
      residence: Residence.fromJson(json['residence'] as Map<String, dynamic>),
      doctors: OldPeopleHome.emptyDoctors(json['doctors']),
    );

Map<String, dynamic> _$OldPeopleHomeToJson(OldPeopleHome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rooms': instance.rooms.map((e) => e.toJson()).toList(),
      'nurses': instance.nurses.map((e) => e.toJson()).toList(),
      'residence': instance.residence.toJson(),
      'doctors': instance.doctors.map((e) => e.toJson()).toList(),
    };
